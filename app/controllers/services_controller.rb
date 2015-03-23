class ServicesController < ApplicationController
  load_and_authorize_resource

  # GET /services
  # GET /services.xml
  def index
    delocalize_dates([:from_fecha_hora_greater_than_or_equal_to, :to_fecha_hora_less_than_or_equal_to]) if params[:search]
    @services = do_index(Service, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @services }
    end
  end

  # GET /services/1
  # GET /services/1.xml
  def show
    @service = Service.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @service }
    end
  end

  # GET /services/new
  # GET /services/new.xml
  def new
    @service = Service.new
    @service.service_type = params[:service_type]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service }
    end
  end

  # GET /services/1/edit
  def edit
    @service = Service.find(params[:id])
  end

  # POST /services
  # POST /services.xml
  def create
    @service = Service.new(params[:service])

    respond_to do |format|
      if @service.save
        format.html { redirect_to(@service, :notice =>  t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @service, :status => :created, :location => @service }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /services/1
  # PUT /services/1.xml
  def update
    @service = Service.find(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to(@service, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @service.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.xml
  def destroy
    prudent_destroy(@service)
  end

  def ajax_therapist_timetable
    unless params[:the_id].blank?
      @therapist = Therapist.find params[:the_id]
      @html_string = render_to_string(:partial => "/services/show_time_ranges.html.erb", :formats => [:html], :layout => false)
      @html_string = @html_string.squish
    end
  end

  #def ajax_calculate_to_fecha_hora
  #  service = Service.new(:from_fecha_hora_string => params[:service][:from_fecha_hora_string])
  #  if service.from_fecha_hora_string
  #    puts "##################################################"
  #    puts service.to_fecha_hora.to_s
  #    puts "##################################################"
  #    #@to_fecha_hora = Service.calculate_to_fecha_hora(service.to_fecha_hora.to_s)
  #    @to_fecha_hora = Time.now
  #  end
  #end

end
