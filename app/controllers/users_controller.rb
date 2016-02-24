# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime
#  updated_at      :datetime
#

class UsersController < ApplicationController
  skip_before_filter :require_user, :only => [:new, :create]
  before_filter :set_user, :only => [:show, :update, :delete]

  def index
    @users = User.all
  end

  def show
    @uploaded_surveys = Survey.where(user_id: @user.id)
    @survey_classifications = Survey.joins(:answer_categories).where(answer_categories: {user_id: @user.id})
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Enhorabuena!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
