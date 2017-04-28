require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  describe 'GET #show' do
    context 'when a user is not signed in' do
      it 'redirects the user to the sign_in path' do
        get :show
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when a user is signed in' do
      it 'renders the show template' do
        user = create(:user)
        sign_in user
        profile = create(:profile, user: user)
        get :show, params: { id: profile, user_id: user.id }
        expect(response).to render_template :show
      end

      it 'assigns the requested profile to @profile' do
        user = create(:user)
        sign_in user
        profile = create(:profile)
        get :show, params: { id: profile }
        expect(assigns(:profile)).to eql profile
      end
    end
  end
  
  describe 'GET #edit' do
    it 'assigns the requested Profile to @profile' do
        user = create(:user)
        sign_in user
        profile = create(:profile)
        get :edit, params: { id: profile }
        expect(assigns(:profile)).to eql profile
    end

    it 'renders the edit template' do
        user = create(:user)
        sign_in user
        profile = create(:profile)
        get :edit, params: { id: profile }
        expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'locates the requested @profile' do
        user = create(:user)
        sign_in user
        profile = create(:profile)
        patch :update, params: { id: profile, profile: attributes_for(:profile) }
        expect(assigns(:profile)).to eq profile
      end
      
      it 'changes @profiles attributes' do
        user = create(:user)
        sign_in user
        profile = create(:profile)
        patch :update, params: { id: profile, profile: attributes_for(:profile, firstname: 'Damien', lastname: 'Potato') }
        profile.reload
        expect(profile.firstname).to eq('Damien')
        expect(profile.lastname).to eql('Potato')
      end

      it 'redirects to the updated profile' do
        user = create(:user)
        sign_in user
        profile = create(:profile)
        patch :update, params: { id: profile, profile: attributes_for(:profile) }
        expect(response).to redirect_to user_profile_path 
      end
    end
  end
end
