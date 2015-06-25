class ActivitiesController < ApplicationController
  def index
    set_content_title("Actividades de usuarios del sistema")
    @activities = PublicActivity::Activity.order("created_at desc").paginate(:page => params[:page], :per_page => per_page(params[:per_page]))
  end
end