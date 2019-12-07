class FormsController < ApplicationController
  before_action :set_form, only: [:show, :destroy]
  protect_from_forgery unless: -> { request.format.json? }
  def index
    @form = Form.all
  end

  def new
    @form = Form.new
  end

  def show
  end

  def create
    @form = Form.create(form_params)
    if @form.save and @form.valid? and @form.errors.count.zero?
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

  def destroy
    @form.destroy
    flash[:success] = 'Successfully Deleted the Form'
    respond_to do |format|
      format.json do
        render json: { data: {},
                       statusCode: 200,
                       statusMessage: 'Successfully deleted the form',
                       disabled: false,
                       error: {} }
      end
      format.html { redirect_to forms_path, notice: 'Form was successfully deleted.' }
    end
  end

  private

  def set_form
    @form = Form.find(params[:id])
  end

  def form_params
    params.permit(:name, :description, :attempts_number)
  end

end
