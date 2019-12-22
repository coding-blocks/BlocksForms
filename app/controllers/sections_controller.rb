class SectionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  def new
    @form = params[:form]
    @question_type = QuestionsType.questions_types_title
    @section = Section.new
    @section.questions.build
  end

  def create
    byebug
    @section = Section.create(section_params)
    if Form.exists?(id: params[:section][:form])
      @section.form_id = params[:section][:form]
    end
    @section.questions.each do |question|
      unless question.question_type_id == 1 or question.question_type_id == 2 or question.question_type_id == 11
        respond_to do |format|
          format.json do
            render json: { data: {},
                           statusCode: 200,
                           statusMessage: 'Unable to create New Section',
                           disabled: false,
                           success: false,
                           error: {'Option': 'Invalid option for current question type'} }
          end
        end
      end
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
    params.require(:section).permit(:name, :description, questions_attributes: [:id, :text, :description, :question_type_id, {options: []}])
  end

end