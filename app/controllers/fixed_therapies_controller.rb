class FixedTherapiesController < ApplicationController
  load_and_authorize_resource

  # GET /fixed_therapies
  # GET /fixed_therapies.xml
  def index
    delocalize_dates([:fecha_inicio_greater_than_or_equal_to, :fecha_fin_less_than_or_equal_to]) if params[:search]
    @fixed_therapies = do_index(FixedTherapy, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fixed_therapies }
    end
  end

  # GET /fixed_therapies/1
  # GET /fixed_therapies/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fixed_therapy }
    end
  end

  # GET /fixed_therapies/new
  # GET /fixed_therapies/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fixed_therapy }
    end
  end

  # GET /fixed_therapies/1/edit
  def edit
  end

  # POST /fixed_therapies
  # POST /fixed_therapies.xml
  def create

    respond_to do |format|
      if @fixed_therapy.save
        format.html { redirect_to(@fixed_therapy, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @fixed_therapy, :status => :created, :location => @fixed_therapy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fixed_therapy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fixed_therapies/1
  # PUT /fixed_therapies/1.xml
  def update

    respond_to do |format|
      if @fixed_therapy.update_attributes(params[:fixed_therapy])
        format.html { redirect_to(@fixed_therapy, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fixed_therapy.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_massive_time_ranges
    @fixed_therapy = FixedTherapy.find(params[:fixed_therapy][:id])
    @time_ranges = TimeRange.update(params[:time_ranges].keys, params[:time_ranges].values)
    @time_ranges.reject! { |tr| tr.errors.empty? }
    if @time_ranges.empty?
      redirect_to  fixed_therapy_path(@fixed_therapy)
    else
      render "edit"
    end
  end

  # DELETE /fixed_therapies/1
  # DELETE /fixed_therapies/1.xml
  def destroy
    prudent_destroy(@fixed_therapy)
  end
end
