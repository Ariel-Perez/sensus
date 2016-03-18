class MapraoController < ApplicationController
  def index
    @users = User.includes(:answer_categories)
    @users = @users.sort_by {|user| -user.answer_categories.count}
  end
end
