class FormsController < ApplicationController
  def index
    @form = Form.all
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.create(form_params)
    if @form.valid? and @form.errors.count.zero?
      flash[:success] = 'Successfully Created New Form'
      render json: { code: 200, success: true }
    elsif !@form.errors.blank?
      flash[:error] = @form.errors.messages
      render json: { code: 404, success: false }
    end
  end

  private

  def form_params
    params.permit(:name, :description, :attempts_number)
  end

end
