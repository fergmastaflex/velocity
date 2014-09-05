class Repo < ActiveRecord::Base
  belongs_to :user

  def total_this_week(user)
    github = Github.new oauth_token: user.token
    closed_ones = github.issues.list(state: 'closed', repo: self.name, labels: '*', since: "#{Time.now.beginning_of_week(:monday).strftime('%F')}T00:00:00Z").count
    closed_twos = github.issues.list(state: 'closed', repo: self.name, labels: '**', since: "#{Time.now.beginning_of_week(:monday).strftime('%F')}T00:00:00Z").count
    closed_threes = github.issues.list(state: 'closed', repo: self.name, labels: '***', since: "#{Time.now.beginning_of_week(:monday).strftime('%F')}T00:00:00Z").count
    total_done_this_week = (closed_ones + (closed_twos * 2) + (closed_threes * 3)).to_d
  end
end
