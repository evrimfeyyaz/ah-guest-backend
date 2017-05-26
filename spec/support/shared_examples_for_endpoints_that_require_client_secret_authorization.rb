shared_examples 'an endpoint that requires client secret authorization' do |http_verb, endpoint|
  context 'with invalid client secret' do
    it 'returns "401 Unauthorized"' do
      send(http_verb, endpoint, headers: request_headers(client_secret: 'INVALID_CLIENT_SECRET'))

      expect(response.status).to eq(401)
    end
  end
end