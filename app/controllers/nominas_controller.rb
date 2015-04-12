class NominasController < ApplicationController
  load_and_authorize_resource

  # GET /nominas
  # GET /nominas.xml
  def index
    delocalize_dates([:fecha_greater_than_or_equal_to, :fecha_less_than_or_equal_to]) if params[:search]
    @nominas = do_index(Nomina, params)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nominas }
    end
  end

  # GET /nominas/1
  # GET /nominas/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nomina }
      format.pdf do
        html = @nomina.pdf_text
        kit = PDFKit.new(html)
        kit.stylesheets << "#{Rails.root}/public/stylesheets/application.css"
        kit.stylesheets << "#{Rails.root}/public/stylesheets/scaffold.css"
        kit.stylesheets << "#{Rails.root}/public/stylesheets/skin1/css/screen.css"
        pdf = kit.to_pdf

        send_data pdf, :filename => "nomina_#{@nomina.nro_nomina}.pdf",
                  :type => "application/pdf",
                  :disposition  => "attachment" # either "inline" or "attachment"
      end
    end
  end

  # GET /nominas/new
  # GET /nominas/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nomina }
    end
  end

  def new_massive
    set_content_title(["Nómina", "Creación masiva"])
    @nomina = Nomina.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nomina }
    end
  end

  # GET /nominas/1/edit
  def edit
  end

  # POST /nominas
  # POST /nominas.xml
  def create

    respond_to do |format|
      if @nomina.save
        @nomina.generate_pdf_text(self)
        @nomina.save
        format.html { redirect_to(@nomina, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @nomina, :status => :created, :location => @nomina }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nomina.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /nominas/1
  # DELETE /nominas/1.xml
  def destroy
    @nomina.destroy

    respond_to do |format|
      format.html { redirect_to(nominas_url) }
      format.xml  { head :ok }
    end
  end

  def create_for_all_therapists
    set_content_title(["Nómina", "Creaci'on masiva"])
    @nomina = Nomina.new(params[:nomina])
    @nomina.therapist = Therapist.first #esto es solo para que pase la validacion
    if @nomina.valid?
      @nominas = Nomina.create_for_all_therapists(@nomina.fecha, self)
      redirect_to(nominas_url, :notice => "Se crearon #{@nominas.size} nominas")
    else
      render 'new_massive'
    end
  end

end
