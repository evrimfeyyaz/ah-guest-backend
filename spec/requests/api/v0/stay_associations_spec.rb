require 'rails_helper'

describe 'POST /api/v0/users/:user_id/associated_stays' do
  it_behaves_like 'an endpoint that requires client secret authorization', :post, '/api/v0/stay_associations'
  it_behaves_like 'an endpoint that requires user authentication', :post, '/api/v0/stay_associations'

  let(:user) { create(:user) }
  let(:stay) { create(:stay, full_name: "#{user.first_name} #{user.last_name}") }

  context 'with check-in date' do
    context 'when one unassociated stay is found that matches the check-in date and the full name' do
      it 'associates the stay with the user' do

      end
    end

    context 'when multiple unassociated stays are found that match the check-in date and the full name' do
      it 'does not associate the stay with the user'
    end

    context 'when no unassociated stay is found that matches the check-in date and the full name' do
      it 'responds with "404 Not Found"'
    end
  end

  context 'with confirmation code' do
    context 'when the code matches the full name of the user' do
      it 'associates the stay with the user'
    end

    context 'when the code does not match the full name of the user' do
      it 'does not associate the stay with the user'
    end

    context 'when there is no stay with the given confirmation code' do
      it 'responds with "404 Not Found"'
    end
  end

  context 'when a user_id parameter is passed along with others' do
    it 'the user_id parameter is ignored'
  end
end