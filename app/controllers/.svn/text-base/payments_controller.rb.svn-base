class PaymentsController < ApplicationController
  load_and_authorize_resource

  # GET /payments
  # GET /payments.xml
  def index
    delocalize_dates([:created_at_greater_than_or_equal_to, :created_at_less_than_or_equal_to]) if params[:search]
    @payments = do_index(Payment, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment }
      format.pdf do
        html = @payment.pdf_text
        kit = PDFKit.new(html)
        kit.stylesheets << "#{Rails.root}/public/stylesheets/application.css"
        kit.stylesheets << "#{Rails.root}/public/stylesheets/scaffold.css"
        kit.stylesheets << "#{Rails.root}/public/stylesheets/skin1/css/screen.css"
        pdf = kit.to_pdf

        send_data pdf, :filename => "recibo_#{@payment.nro_recibo}.pdf",
        :type => "application/pdf",
        :disposition  => "attachment" # either "inline" or "attachment"
      end
    end
  end

  # GET /payments/new
  # GET /payments/new.xml
  def new
    if params[:patient_id] && params[:importe]
      @payment.patient_id = params[:patient_id]
      @payment.importe = params[:importe].to_i
      session[:payment_goto] = "/presences/today_sessions"
    else
      session[:payment_goto] = nil
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payment }
    end
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.xml
  def create
    max_nro_recibo = Payment.maximum(:nro_recibo)
    @payment.nro_recibo = max_nro_recibo + 1 if max_nro_recibo
    @payment.nro_recibo = Settings.recibo_start_folio if !max_nro_recibo

    @payment.pdf_text = render_to_string(:partial => "html_origin", :layout => false)
    respond_to do |format|
      if @payment.save
        #format.html { redirect_to(session[:payment_goto] ? session[:payment_goto] : @payment, :notice => t("screens.notice.successfully_created")) }
        format.html { redirect_to(@payment, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @payment, :status => :created, :location => @payment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @payment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.xml
  def destroy
    prudent_destroy(@payment)
  end

end
