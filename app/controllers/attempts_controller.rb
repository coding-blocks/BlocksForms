class AttemptsController < ApplicationController
  def new
    @attempt = Attempt.new
    @form = Form.find(params[:id])
  end

  def create
    byebug
  end
end