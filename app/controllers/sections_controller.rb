class SectionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  def new
    @section = Section.new
  end

  def create
    byebug
    @section = Section.create(section_params)
    if @section.save and @section.valid? and @section.errors.count.zero?
      flash[:success] = 'Successfully Created New Form'
      render json: { data: {},
                     statusCode: 200,
                     statusMessage: 'Successfully Created New Section',
                     disabled: false,
                     error: {} }
    else
      flash[:error] = @form.errors.messages
      render json: { data: {},
                     statusCode: 500,
                     statusMessage: 'Unable to create New Section',
                     disabled: false,
                     error: @form.errors.messages }
    end
  end

  private

  def set_section
    @form = Form.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:name, :description, :button, :questions_attributes)
  end
end