class HomeController < ApplicationController
  def index
    @repos = current_user.repos.all
    @github = Github.new oauth_token: current_user.token
    closed_ones = @github.issues.list(state: 'closed', labels: '*', since: "#{Time.now.beginning_of_week(:monday).strftime('%F')}T00:00:00Z").count
    closed_twos = @github.issues.list(state: 'closed', labels: '**', since: "#{Time.now.beginning_of_week(:monday).strftime('%F')}T00:00:00Z").count
    closed_threes = @github.issues.list(state: 'closed', labels: '***', since: "#{Time.now.beginning_of_week(:monday).strftime('%F')}T00:00:00Z").count
    @total_done_this_week = (closed_ones + (closed_twos * 2) + (closed_threes * 3)).to_d
    #weekly goal to be a project specific thing? until then, i'll do 15
    @percent_complete = (@total_done_this_week.to_d / 15.to_d) * 100
  end
end