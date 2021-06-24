class UsersController < ApplicationController

 
    get '/signup' do 
        if session[:user_id] == nil
          erb :"/users/new"
        else
          redirect '/tweets'
        end
      end


  post '/signup' do
    if logged_in?
        redirect to "/tweets"
    end
      user = User.new(params)

    if user.username.blank? || user.email.blank? || user.password.blank? || User.find_by_email(params["email"])
       redirect "/signup"   
    else 
        user.save
        session[:user_id] = user.id 
        redirect "/tweets"
    end
  end
    
    get '/login' do
      if logged_in?
         redirect to "/tweets"
       end
        erb :"/users/login"
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        # check and see if there is a user with that email addess
        # is the password correct?
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/login"
        end
    end

    get '/logout' do
        if session[:user_id] == nil
            redirect "/"
        else
            session.clear
          redirect '/login'
        end
    end 
    

    get '/users/:slug' do 
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
    end

end
