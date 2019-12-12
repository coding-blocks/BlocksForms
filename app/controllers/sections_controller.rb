class SectionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  def new
    @form = params[:form]
    @question_type = QuestionsType.questions_types_title
    @section = Section.new
  end

  def create
    @section = Section.create(section_params)
    if Form.exists?(id: params[:section][:form])
      @section.form_id = params[:section][:form]
    end
    if @section.save and @section.valid?
      flash[:success] = 'Successfully Created New Form'
      respond_to do |format|
        format.json do
          render json: { data: { section: @section, questions: @section.questions },
                         statusCode: 200,
                         statusMessage: 'Successfully Created New Section',
                         disabled: false,
                         success: true,
                         error: {} }
        end
      end
    else
      flash[:error] = @section.errors.messages
      respond_to do |format|
        format.json do
          render json: { data: {},
                         statusCode: 200,
                         statusMessage: 'Unable to create New Section',
                         disabled: false,
                         success: false,
                         error: @section.errors.messages }
        end
      end
    end
  end

  private

  def set_section
    @form = Form.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:name, :description, questions_attributes: [:id, :text, :description, :question_type_id, options_attributes: [:id, :text]])
  end

end