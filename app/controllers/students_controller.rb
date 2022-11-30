class StudentsController < ApplicationController
        rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    
        def index
        students = Student.all 
        render json: students
        end
    
        def create
        student = Student.create!(student_params)
        render json: student, status: :created
        rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
        end
    
        def show
        student = Student.find(params[:id])
        render json: student
        end
    
        def update
        student = Student.find(params[:id])
        Student.update(student_params)
        render json: student
    
        end
    
        def destroy
        student = Student.find(params[:id])
        Student.destroy
        head :no_content
        end
    
        private
    
        def render_not_found_response
            render json: {error: "Student not found"}, status: :not_found
        end
    
        def student_params
            params.permit(:name)
        end
    
    end
    
end
