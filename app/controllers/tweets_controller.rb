class TweetsController < ApplicationController

    def create
        @tweet = Tweet.new(tweet_params)
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        if session
            user = session.user

            render json: {
                tweet: {
                    username: user.username,
                    message: @tweet.message
                }
            }
        else
            render json: {
                success: false
            }
        end

    end

    def destroy
        tweet = Tweet.find_by(id: params[:id])
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        if session and tweet and tweet.destroy
            render json: { success: true }
        else
            render json: { success: false }
        end
    end

    def index
        @tweets = Tweet.all

        render 'tweets/index'
    end

    def index_by_user
        user = User.find_by(username: params[:username])
        @tweets = user.tweets

        if @tweets
            render 'tweets/index_by_user'
        else 
            render json: {
                tweets: []
        }
        end
    end

    private

    def tweet_params
        params.require(:tweet).permit(:message)
    end

end
