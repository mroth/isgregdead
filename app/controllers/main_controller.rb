class MainController < ApplicationController
  def index
    # add caching, heroku style: http://devcenter.heroku.com/articles/http-caching#caching_dynamic_content_by_age
    # cache time: 3 minutes for now, let's see how that works out for us
    response.headers['Cache-Control'] = 'public, max-age=180'
        
    #get github stuff
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
    #fuck it, no reason to protect these, they have no user auth and no rate permissions, just using to not get hit by default limits
    Twitter.configure do |config|
      config.consumer_key = 'sYY25xkLORSWsuvs2AtXwQ'
      config.consumer_secret = 'q3CJ9IPRqQyJEqs0si2doOv1ifAD8bAybT1wBpXJw'
    end
     
    twitter = Twitter::Client.new
    @last_tweet = twitter.user('gregory80').status
    @last_tweet_msg = @last_tweet.text
    @last_tweet_time = Time.parse(@last_tweet.created_at)
    
    #other helpful stuff
    @last_time = (@last_commit_time > @last_tweet_time) ? @last_commit_time : @last_tweet_time
    @last_service = (@last_commit_time > @last_tweet_time) ? 'github' : 'twitter'
    
  end

end
