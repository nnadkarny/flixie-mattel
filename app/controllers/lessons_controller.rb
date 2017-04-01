class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrolled_for_current_course, unless: :course_instructor
  
  def show
  end

  private

  def require_enrolled_for_current_course
    course = current_lesson.section.course
    if !current_user.enrolled_in?(course)
      redirect_to course_path(course), alert: 'You are not currently enrolled in this course.' 
    end
  end

  def course_instructor
    current_user == current_lesson.section.course.user
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
