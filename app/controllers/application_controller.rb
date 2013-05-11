class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :loadCourse


  def loadCourse
    @courses = Course.all
  end
end
