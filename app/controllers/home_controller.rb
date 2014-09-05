class HomeController < ApplicationController
  def index
    @github = Github.new oauth_token: current_user.token
  end
end