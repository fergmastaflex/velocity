class Repo < ActiveRecord::Base
  belongs_to :user

  def total_this_week(repo_name,user)
    github = Github.new oauth_token: user.token
    owner = github.repos.list.select{|x| x.name == 'subconnect'}.first.owner.login
    ones = github.issues.list(state: 'closed',user: owner, repo: self.name, labels: '*', since: "#{Time.now.beginning_of_week(:monday).strftime('%F')}T00:00:00Z", assignee: user.username).count
    twos = github.issues.list(state: 'closed',user: owner, repo: self.name, labels: '**', since: "#{Time.now.beginning_of_week(:monday).strftime('%F')}T00:00:00Z", assignee: user.username).count
    threes = github.issues.list(state: 'closed',user: owner, repo: self.name, labels: '***', since: "#{Time.now.beginning_of_week(:monday).strftime('%F')}T00:00:00Z", assignee: user.username).count

    total_done_this_week = (ones + (twos * 2) + (threes * 3)).to_d
  end



end
