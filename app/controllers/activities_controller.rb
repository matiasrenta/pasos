class ActivitiesController < ApplicationController
  def index
    set_content_title("Actividades de usuarios del sistema")
    @activities = PublicActivity::Activity.order("created_at desc")
  end
end