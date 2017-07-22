require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do

  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  describe 'GET #index' do

    before :each do
      sign_in user
      create(:friendship, user: user, friend: user2, accepted: true)
      get :index
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end

    it 'populates an array with the current users friends' do
      expect(assigns(:friends)).to match_array([user2])
    end
  end
  
  describe 'POST #create' do

    before :each do
      sign_in user
    end

    it 'creates a new friendship request' do
      expect{
        post :create, params: { friendship: { friend: user2 } }
      }.to change(Friendship, :count).by(1)
    end
  end
end
