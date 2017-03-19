Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope controller: :home do
    get '/', action: 'index'
  end

  scope controller: :blog_posts do
    get '/blog/:post_slug', action: 'show'
  end
end
