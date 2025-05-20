class UsersController < ApplicationController

  def show
    @user = User.find_by(params[:id])
    @prototypes = @user.prototype
  end
  
end
