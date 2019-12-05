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
      render json: { data: {},
                     statusCode: 200,
                     statusMessage: 'Successfully Created New Form',
                     disabled: false,
                     error: {} }
    elsif !@form.errors.blank?
      flash[:error] = @form.errors.messages
      render json: { data: {},
                     statusCode: 500,
                     statusMessage: 'Unable to create New Form',
                     disabled: false,
                     error: @form.errors.messages }
    end
  end

  private

  def form_params
    params.permit(:name, :description, :attempts_number)
  end

end
