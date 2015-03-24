class CancellationsController < ApplicationController
  load_and_authorize_resource

  # GET /cancellations
  # GET /cancellations.xml
  def index
    delocalize_dates([:cancel_from_fecha_greater_than_or_equal_to, :cancel_from_fecha_less_than_or_equal_to,
                      :cancel_to_fecha_greater_than_or_equal_to, :cancel_to_fecha_less_than_or_equal_to,
                      :service_from_fecha_hora_greater_than_or_equal_to, :service_from_fecha_hora_less_than_or_equal_to]) if params[:search]
    @cancellations = do_index(Cancellation, params)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cancellations }
    end
  end

  # GET /cancellations/1
  # GET /cancellations/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cancellation }
    end
  end

  # GET /cancellations/new
  # GET /cancellations/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cancellation }
    end
  end

  # GET /cancellations/1/edit
  def edit
  end

  # POST /cancellations
  # POST /cancellations.xml
  def create

    respond_to do |format|
      if @cancellation.save
        format.html { redirect_to(@cancellation, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @cancellation, :status => :created, :location => @cancellation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cancellation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cancellations/1
  # PUT /cancellations/1.xml
  def update

    respond_to do |format|
      if @cancellation.update_attributes(params[:cancellation])
        format.html { redirect_to(@cancellation, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cancellation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cancellations/1
  # DELETE /cancellations/1.xml
  def destroy
    @cancellation.destroy

    respond_to do |format|
      format.html { redirect_to(cancellations_url) }
      format.xml  { head :ok }
    end
  end
end
