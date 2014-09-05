class ReposController < ApplicationController
  def new
    @repo = current_user.repos.new
    @github = Github.new oauth_token: current_user.token
    @repo_list = @github.repos.list.collect(&:name)
  end

  def create
    @repo = Repo.new(repo_params)

    if @repo.save
      redirect_to authenticated_root_path, notice: 'You just added a repo!'
    else
      render :new, alert: 'Something went wrong while adding your repo'
    end
  end

  def edit
    @repo = Repo.find(params[:id])
  end

  def update
    @repo = Repo.find(params[:id])

    if @repo.update_attributes(repo_params)
      redirect_to authenticated_root_path, notice: 'Updated!'
    else
      render :edit, alert: 'Something went wrong while editing your repo'
    end
  end

  def repo_params
    params.require(:repo).permit(:name, :weekly_goal, :user_id)
  end
end
