class TherapistsController < ApplicationController
  load_and_authorize_resource

  # GET /therapists
  # GET /therapists.xml
  def index
    @therapists = do_index(Therapist, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @therapists }
    end
  end

  # GET /therapists/1
  # GET /therapists/1.xml
  def show
    @services = Service.dues(Date.today + 15.days).by_therapist(@therapist.id).order_by_date
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @therapist }
    end
  end

  # GET /therapists/new
  # GET /therapists/new.xml
  def new
    @therapist.state = State.active

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @therapist }
    end
  end

  # GET /therapists/1/edit
  def edit
  end

  # POST /therapists
  # POST /therapists.xml
  def create

    respond_to do |format|
      if @therapist.save
        format.html { redirect_to(@therapist, :notice => "Ingrese los rangos horarios en que trabaja este terapeuta") }
        format.xml  { render :xml => @therapist, :status => :created, :location => @therapist }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @therapist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /therapists/1
  # PUT /therapists/1.xml
  def update

    respond_to do |format|
      if @therapist.update_attributes(params[:therapist])
        format.html { redirect_to(@therapist, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @therapist.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_massive_time_ranges
    @therapist = Therapist.find(params[:therapist][:id])
    authorize! :update, @therapist
    @time_ranges = TimeRange.update(params[:time_ranges].keys, params[:time_ranges].values)
    @time_ranges.reject! { |tr| tr.errors.empty? }
    if @time_ranges.empty?
      redirect_to(@therapist, :notice => 'Los horarios fueron actualizados correctamente')
    else
      @therapist.errors.add(:base, "No se a podido hacer la modificacion en los horarios")
      render(:action => "edit")
    end
  end

  # DELETE /therapists/1
  # DELETE /therapists/1.xml
  def destroy
    prudent_destroy(@therapist)
  end



  def ajax_get_available_hours
    @the_id = params[:the_id]
    @select_options = TherapistSchedule.available_hours(@the_id)
        if params[:the_this_html_id].include?("patient_therapies")
          #debo de obtener el id del dropdown que tiene los horarios, se diferencian por el nro, son del tipo:
          #para el new: patient_therapies_attributes_1400520810110_therapist_schedule_ids
          #para el edit: patient_therapies_attributes_1_therapist_schedule_ids
          params[:the_this_html_id].split("_").each do |the_number|
            tn = the_number.to_i
            entity = "therapies"
            @changing_dropdown_id = "#patient_#{entity}_attributes_#{tn}_therapist_schedule_ids" if tn != 0 || the_number == "0" # este if tiene sentido aunque parezca que no. tn puede ser cero porque no hay numeros en the_number al hacer the_number.to_i
          end
        end

    respond_to do |format|
      format.html { render :layout => nil, :status => 200 }
      format.js { render :status => 200 }
    end
  end


end
