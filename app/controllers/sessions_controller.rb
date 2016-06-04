class SessionsController < ApplicationController
   
   def new   #going to render a form
      
   end
   
   def create  #form submission handled here
      #debugger
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
         session[:user_id] = user.id    #stored by browser and used for requests
         flash[:success] = "You have successfully logged in"
         redirect_to user_path(user) #go to user's page
      else
         flash.now[:danger] = "There was something wrong with your log in information"  #only exists for one http request
         render 'new'
      end
   end
   
   def destroy  #to stop session and move user to logout state
      session[:user_id] = nil
      flash[:success] = "You have logged out"
      redirect_to root_path
   end
   
end