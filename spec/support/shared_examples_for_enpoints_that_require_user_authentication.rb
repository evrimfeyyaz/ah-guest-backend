shared_examples 'an endpoint that requires user authentication' do |http_verb, endpoint_without_interpolation|
  let(:endpoint)  { endpoint_without_interpolation % { user_id: user.id } }

  context 'when ID in ID header belongs to a user' do
    context 'but authentication token header does not exist' do
      it 'returns "401 Unauthorized"' do
        send(http_verb, endpoint, headers: request_headers(user_id: user.id, auth_token: nil))

        expect(response.status).to eq(401)
      end
    end

    context 'and authentication token does not match user' do
      it 'returns "401 Unauthorized"' do
        send(http_verb, endpoint, headers: request_headers(user_id: user.id, auth_token: 'WRONGTOKEN'))

        expect(response.status).to eq(401)
      end
    end

    context 'and authentication token matches another user' do
      it 'returns "401 Unauthorized"' do
        another_user = create(:user)

        send(http_verb, endpoint, headers: request_headers(user_id: user.id, auth_token: another_user.auth_token))

        expect(response.status).to eq(401)
      end
    end

    context 'and authentication token matches user' do
      it 'does not return "401 Unauthorized"' do
        send(http_verb, endpoint, headers: request_headers(user: user))

        expect(response.status).not_to eq(401)
      end
    end
  end

  context 'when authentication token exists' do
    context 'but ID header is empty' do
      it 'returns "401 Unauthorized"' do
        send(http_verb, endpoint, headers: request_headers(user_id: nil, auth_token: user.auth_token))

        expect(response.status).to eq(401)
      end
    end
  end
end