Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  get 'new' => 'home#new'
  devise_for :users, controllers: { registrations: 'registrations' }

  
  resources :blogs do 
    resources :comments do 
      get :showNotify

    end
    post :addLike
    delete :destroyLike

  end 



  get 'seeBlog' => 'blogs#seeBlog'
  get 'addBlog' => 'blogs#addBlog'
  get 'myBlog' => 'blogs#myBlog'
  get 'showBlog/:blog_id' => 'blogs#showBlog', as: 'showBlog'

  get 'seeNotification'=>'comments#seeNotification'

end
