shared_examples 'an endpoint that requires client secret authentication' do |http_verb, endpoint|
  context 'when the client secret is invalid' do
    it 'responds with "401 Unauthorized"' do
      send(http_verb, endpoint, headers: request_headers(client_secret: 'INVALID_CLIENT_SECRET'))

      expect(response.status).to eq(401)
      expect(response_json['error_type']).to eq('client_authentication')
      expect(response_json['errors']['client_secret'][0]).to eq({ 'error' => 'invalid',
                                                                  'full_message' => 'Client secret is invalid' })
    end
  end

  context 'when the client secret is nil' do
    it 'responds with "401 Unauthorized"' do
      send(http_verb, endpoint, headers: request_headers(client_secret: nil))

      expect(response.status).to eq(401)
      expect(response_json['error_type']).to eq('client_authentication')
      expect(response_json['errors']['client_secret'][0]).to eq({ 'error' => 'blank',
                                                                  'full_message' => 'Client secret must exist' })
    end
  end
end