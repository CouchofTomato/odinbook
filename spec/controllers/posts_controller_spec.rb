require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:user) { create(:user) }
  let(:new_post) { create(:post, user: user) }
  let(:comments) { create(:comment, post: new_post) }
  

  describe 'GET #show' do

    before :each do
      sign_in user

      get :show, params: { id: new_post }
    end

    context 'when a user is not signed in' do
      it 'redirects the user to the sign_in path' do
        sign_out(user)
        get :show, params: { id: new_post }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when a user is signed in' do
      it 'renders the show template' do
        expect(response).to render_template :show
      end

      it 'assigns the requested post to @post' do
        expect(assigns(:post)).to eql new_post
      end

      it 'assigns the @post comments to @comments' do
        expect(assigns(:comments)).to eql comments
      end
    end
  end

  describe 'GET #index' do

    before :each do
      sign_in user
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'populates an array with posts for the user and friends' do
      user2 = create(:user)
      user.friendships.create(friend: user2, accepted: true)
      3.times do
        user.posts.create(attributes_for(:post))
        user2.posts.create(attributes_for(:post))
      end
      get :index
      expect((assigns(:posts)).count).to eql 6
    end
  end

  describe 'GET #new' do
    
    before :each do
      sign_in user
    end

    it 'assigns a new Post to @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
    
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    
    before :each do
      sign_in user
    end

    it 'assigns the requested Post to @post' do
      get :edit, params: { id: new_post }
      expect(assigns(:post)).to eq new_post
    end

    it 'renders the edit template' do
      get :edit, params: { id: new_post }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    
    before :each do
      sign_in user
    end

    context 'with valid attributes' do
      it 'saves the new post in the database' do
        expect{
          post :create, params: { post: attributes_for(:post) }
        }.to change(Post, :count).by(1)
      end

      it 'redirects to posts#show' do
        post :create, params: { post: attributes_for(:post) }
        expect(response).to redirect_to user_post_path(assigns[:post])
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new post in the database' do
        expect{
          post :create, params: { post: attributes_for(:post, content: nil) }
        }.not_to change(Post, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { post: attributes_for(:post, content: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      sign_in user
      @post = create(:post,
                     user: user,
                     content: "hello spaceman")
    end
    
    context 'valid attributes' do
      it 'locates the requested @post' do
        patch :update, params: { id: @post, post: attributes_for(:post) }
        expect(assigns(:post)).to eq(@post)
      end

      it 'changes @posts attributes' do
        patch :update, params: { id: @post, post: attributes_for(:post, content: "Goodbye Spaceman!") }
        @post.reload
        expect(@post.content).to eql('Goodbye Spaceman!')
      end

      it 'redirects to the updated contact' do
        patch :update, params: { id: @post, post: attributes_for(:post) }
        expect(response).to redirect_to user_post_path(@post) 
      end
    end

    context 'with invalid attributes' do
      it 'does not change the posts atributes' do
        patch :update, params: {id: @post, post: attributes_for(:post, content: nil) }
        @post.reload
        expect(@post.content).not_to eq nil
        expect(@post.content).to eq "hello spaceman"
      end

      it 're-renders the edit template' do
        patch :update, params: { id: @post, post: attributes_for(:post, content: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      sign_in user
      @post = create(:post)
    end

    it 'deletes the post' do
      expect{
        delete :destroy, params: { id: @post }
      }.to change(Post, :count).by(-1)
    end

    it 'redirects to posts#index' do
      delete :destroy, params: { id: @post }
      expect(response).to redirect_to user_posts_path
    end
  end
end
