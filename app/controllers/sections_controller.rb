class SectionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  #before_action :sanitize_page_params, only: [:create]
  def new
    @form = params[:form]
    @section = Section.new
  end

  def create
    @section = Section.create(section_params)
    if Form.exists?(id: params[:section][:form])
      @section.form_id = params[:section][:form]
    end
    if @section.save and @section.valid?
      flash[:success] = 'Successfully Created New Form'
      render json: { data: {},
                     statusCode: 200,
                     statusMessage: 'Successfully Created New Section',
                     disabled: false,
                     error: {} }
    else
      flash[:error] = @section.errors.messages
      render json: { data: {},
                     statusCode: 500,
                     statusMessage: 'Unable to create New Section',
                     disabled: false,
                     error: @section.errors.messages }
    end
  end

  private

  def set_section
    @form = Form.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:name, :description, questions_attributes: [:id, :text, :description])
  end

  def sanitize_page_params
    params[:section][:form] = Form.find(params[:section][:form])
  end
end