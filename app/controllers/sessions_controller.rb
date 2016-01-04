class SessionsController < ApplicationController
    
    def update
        id = params[:id].to_i
        session[:id] = User::ROLES.has_key?(id) ? id : 0
        flash[:success] = "your role #{User::ROLES[id]}"
        redirect_to root_path
    end
end
