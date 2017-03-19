class BlogPostsController < ApplicationController
  def show
    post_slug = params[:post_slug]
    case post_slug
    when 'overmind'
      render 'overmind'
    end
  end
end
