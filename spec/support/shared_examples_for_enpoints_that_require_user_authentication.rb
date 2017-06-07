shared_examples 'an endpoint that requires user authentication' do |http_verb, endpoint_without_interpolation|
  let(:user) { create(:user) }

  let(:endpoint) {
    if defined?(object) && object.present?
      endpoint_without_interpolation % { object_id: object.id }
    else
      endpoint_without_interpolation
    end
  }

  context 'when ID in ID header belongs to a user' do
    context 'but authentication token header does not exist' do
      it 'responds with "401 Unauthorized"' do
        send(http_verb, endpoint, headers: request_headers(user_id: user.id, auth_token: nil))

        expect(response.status).to eq(401)
        expect(response_json['error_type']).to eq('user_authentication')
        expect(response_json['errors']['auth_token'][0]).to eq({ 'error' => 'blank',
                                                                 'full_message' => 'Auth token must exist' })
      end
    end

    context 'and authentication token does not match user' do
      it 'responds with "401 Unauthorized"' do
        send(http_verb, endpoint, headers: request_headers(user_id: user.id, auth_token: 'WRONGTOKEN'))

        expect(response.status).to eq(401)
        expect(response_json['error_type']).to eq('user_authentication')
        expect(response_json['errors']['auth_token'][0]).to eq({ 'error' => 'invalid',
                                                                 'full_message' => 'Auth token is invalid' })
      end
    end

    context 'and authentication token matches another user' do
      it 'responds with "401 Unauthorized"' do
        another_user = create(:user)

        send(http_verb, endpoint, headers: request_headers(user_id: user.id, auth_token: another_user.auth_token))

        expect(response.status).to eq(401)
        expect(response_json['error_type']).to eq('user_authentication')
        expect(response_json['errors']['auth_token'][0]).to eq({ 'error' => 'invalid',
                                                                 'full_message' => 'Auth token is invalid' })
      end
    end

    context 'and authentication token matches user' do
      it 'does not respond with "401 Unauthorized"' do
        send(http_verb, endpoint, headers: request_headers(user: user))

        expect(response.status).not_to eq(401)
      end
    end
  end

  context 'when authentication token exists' do
    context 'but ID header is empty' do
      it 'responds with "401 Unauthorized"' do
        send(http_verb, endpoint, headers: request_headers(user_id: nil, auth_token: user.auth_token))

        expect(response.status).to eq(401)
        expect(response_json['error_type']).to eq('user_authentication')
        expect(response_json['errors']['user_id'][0]).to eq({ 'error' => 'blank',
                                                              'full_message' => 'User ID must exist' })
      end
    end
  end
end