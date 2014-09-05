class HomeController < ApplicationController
  def index
    @repos = current_user.repos.all
    @github = Github.new oauth_token: current_user.token
  end
end