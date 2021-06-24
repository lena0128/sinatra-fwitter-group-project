
class TweetsController < ApplicationController

    get '/tweets' do
        if !logged_in?
            redirect "/login"
        end
        @tweets = Tweet.all
        erb :'/tweets/index'
    end

    get '/tweets/new' do
        if !logged_in?
            redirect "/login"  
        end
        erb :"/tweets/new"
    end

    get "/tweets/:id" do
        if logged_in?
        @tweet = Tweet.find(params[:id])
        @tweet.user = current_user
        erb :"/tweets/show"
        else
            redirect "/login"
      end
    end

    post "/tweets" do
        if !logged_in?
            redirect "/login"
        end

        if !params[:content].empty?
        @tweet = Tweet.new(:content => params[:content])
        @tweet.user = current_user
        @tweet.save
          redirect "/tweets"
        else
            redirect "/tweets/new"  
        end
    end


    get "/tweets/:id/edit" do
        if !logged_in?
            redirect "/login"
        end
        @tweet = Tweet.find(params["id"])
        if @tweet.user == current_user
           erb :'/tweets/edit'
        else
            redirect "/tweets"
        end
    end
    

    patch '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
        end
        if params[:updated_content] != ""
            @tweet.content = params[:updated_content]
            @tweet.save
        end
        redirect "/tweets/#{@tweet.id}/edit"
    end



      delete "/tweets/:id" do
        if !logged_in?
            redirect "/login"
        end
        @tweet = Tweet.find(params["id"])
        if logged_in? && @tweet.user == current_user
           @tweet.delete
           redirect "/tweets"
        else
            redirect "/login"
        end
      end


    end
