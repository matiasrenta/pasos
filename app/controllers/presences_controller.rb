class PresencesController < ApplicationController
  load_and_authorize_resource :unless => :today_sessions

  # GET /presences
  # GET /presences.xml
  def index
    delocalize_dates([:fecha_hora_greater_than_or_equal_to, :fecha_hora_less_than_or_equal_to]) if params[:search]
    @presences = do_index(Presence, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @presences }
    end
  end

  # GET /presences/1
  # GET /presences/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @presence }
    end
  end

  # GET /presences/new
  # GET /presences/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @presence }
    end
  end

  # GET /presences/1/edit
  def edit
  end

  # POST /presences
  # POST /presences.xml
  def create
    unless params[:presence][:fecha_hora].blank?
      @presence.fecha_hora = ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime(params[:presence][:fecha_hora], '%d/%m/%Y %H:%M').to_s(:db))
    end

    respond_to do |format|
      if @presence.save
        if params[:from_today]
          format.html { redirect_to("/presences/today_sessions", :notice => t("screens.notice.successfully_created")) }
          format.xml  { render :xml => @presence, :status => :created, :location => @presence }
        else
          format.html { redirect_to(@presence, :notice => t("screens.notice.successfully_created")) }
          format.xml  { render :xml => @presence, :status => :created, :location => @presence }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @presence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /presences/1
  # PUT /presences/1.xml
  def update

    respond_to do |format|
      if @presence.update_attributes(params[:presence])
        format.html { redirect_to(@presence, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @presence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /presences/1
  # DELETE /presences/1.xml
  def destroy
    prudent_destroy(@presence)
  end

  def today_sessions
    set_content_title(["Asistencia del día", l(Time.zone.now.to_date, :format => :long_day)])
    #@therapies = Therapy.today_sessions_not_presenced
    @therapies = Therapy.actives.sessions_in_date(Time.zone.now.to_date)
    @presences = Presence.for_today_list
  end

end
