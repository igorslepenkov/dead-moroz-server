require 'rails_helper'

RSpec.describe Users::ChildPresentsController, type: :controller do
  before :each do
    User.create(id: 1, name: 'Igor', role: 'child', email: 'example@example.by', password: 'example123',
                confirmed_at: Time.now)
  end

  describe 'POST create' do
    context 'if params are valid' do
      it 'adds 1 child_presents to user' do
        post :create, params: { child_present: { "0": { name: 'IPhone' } }, id: 1 }
        expect(User.find(1).child_presents.count).to eq(1)
      end

      it 'responses with child presents for user' do
        post :create, params: { child_present: { "0": { name: 'IPhone' } }, id: 1 }
        expect(response.body).to eq(User.find(1).child_presents.to_json)
      end

      it 'responses with status code 200 (ok)' do
        post :create, params: { child_present: { "0": { name: 'IPhone' } }, id: 1 }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'if params are invalid' do
      it 'responses with message and errors hash' do
        post :create, params: { child_presents: { "0": { name: '' } }, id: 1 }
        expect(response.body).to eq({ message: 'Errors have occured', errors: ['Child presents is invalid'] }.to_json)
      end

      it 'responses with status code 400 (bad_request)' do
        post :create, params: { child_presents: { "0": { name: '' } }, id: 1 }
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not create any child presents for user' do
        post :create, params: { child_presents: { "0": { name: '' } }, id: 1 }
        expect(User.find(1).child_presents.count).to eq(0)
      end
    end
  end
end
