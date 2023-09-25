
class StudentsController < ApplicationController

    def index
        render json: {status: :ok}
    end

    def next_activity
        begin
            student = get_student
            #debugger
            activity = ActivityService.new(student).get_next_activity
            render json: activity
        rescue Exception => e 
            render json: {error: e.message}, status: e.code
        end
    end

    protected

    def get_student
        student = Student.where(id: params[:student_id]).first
        if student.blank?
            raise Errors::NoStudentFoundError.new("student not found", 404)
        end
        student
    end
end