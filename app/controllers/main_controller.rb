class MainController < ApplicationController
  def index
        
    #get github stuff
    #gh = Octokit::Client.new(:login => "mroth", :password => "d3fc0g")
    gh = Octokit::Client.new(:login => ENV['GITHUB_USERNAME'], :password => ENV['GITHUB_PASSWORD'])
    commits = gh.commits("bitly/prototypes", branch = "v1")
    commits.each do |c|
      if c.committer.login == "gregory80"
        @last_commit = c
        break
      end
    end
    @last_commit_time = Time.parse(@last_commit.committed_date)
    @last_commit_msg = @last_commit.message
    @last_commit_branch = 'bitly/prototypes:v1' #TODO: handle multiple branches for this
    
    #get twitter stuff
    twitter = Twitter::Client.new
    @last_tweet = twitter.user('gregory80').status
    @last_tweet_msg = @last_tweet.text
    @last_tweet_time = Time.parse(@last_tweet.created_at)
    
    #other helpful stuff
    @last_time = (@last_commit_time > @last_tweet_time) ? @last_commit_time : @last_tweet_time
    @last_service = (@last_commit_time > @last_tweet_time) ? 'github' : 'twitter'
    
  end

end
