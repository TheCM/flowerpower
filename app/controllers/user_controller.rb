class UserController < ApplicationController

  def new
    @saved = false
    @user_data = registration_params
    @correct =  user_data_correct?(@user_data)
    if @correct
      @user = User.new({:email => @user_data[:email], :password => @user_data[:password]})
      @saved = @user.save
    end
  end

  def user_data_correct?(user_data)

    /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i =~ user_data[:email]
    if !Regexp.last_match(1) or user_data[:password].length < 8 or user_data[:password] != user_data[:password_confirmation]
      return false
    else
      return true
    end
  end


  def registration_new
    @user = User.new
  end

  def list_of_users
    @users = User.all
  end

  def delete
    @user = User.find_by(id: params[:format])
    @user.delete
    redirect_to :back
  end

  def data_edit

  end

  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def admin_panel

  end

  def user_panel

  end
end
