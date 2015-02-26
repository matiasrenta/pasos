class PatientsController < ApplicationController
  load_and_authorize_resource

  # GET /patients
  # GET /patients.xml
  def index
    delocalize_dates([:fecha_ingreso_greater_than_or_equal_to, :fecha_ingreso_less_than_or_equal_to]) if params[:search]
    @patients = do_index(Patient, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @patients }
    end
  end

  # GET /patients/1
  # GET /patients/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.xml
  def new
    @patient.state = State.active
    @patient.costo_terapia = Settings.therapy_cost

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.xml
  def create

    respond_to do |format|
      if @patient.save
        format.html { redirect_to(@patient, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.xml
  def update
    #fecha_hora = 09/06/2014 08:00
    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to(@patient, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.xml
  def destroy
    prudent_destroy(@patient)
  end
end
