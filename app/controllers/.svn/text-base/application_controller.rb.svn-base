class ApplicationController < ActionController::Base
  check_authorization :unless => :devise_controller?
  skip_authorization_check :only => [:index, :access_denied]

  before_filter :set_cache_buster
  before_filter :authenticate_user!
  before_filter :set_content_title
  #before_filter :set_user_language

  protect_from_forgery

  #load_and_authorize_resource :except => :index

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def access_denied
    set_content_title(t("screens.labels.access_denied"))
  end

  def action_controller_error
    raise ActiveRecord::RecordNotFound.new("Probably a routing error")
  end

  protected ############################################ PROTECTED #################################################

  def set_content_title(title = "", separator = " - ")
    content_title = ""

    if title.blank?
      if action_name == "index"
        title = [t("activerecord.models."+controller_name.camelize)]
      else
        title = [t("activerecord.models."+controller_name.camelize.singularize), t("activerecord.actions."+action_name)]
      end
    end

    i=0
    title.each do |title_part|
      case i
        when 0: content_title = ("<h1>"+title_part+"</h1>").html_safe
        when 1: content_title += ("<h2>" + separator + title_part + "</h2>").html_safe
        else    content_title += ("<h3>" + separator + title_part + "</h3>").html_safe
      end
      i += 1
    end
    session["content_title"] = content_title
  end

  def set_user_language
    I18n.locale = 'es' #current_user.language if user_signed_in?
  end

  def delocalize_dates(fields)
    fields.each do |field|
      date_s = params[:search][field]
      unless date_s.blank?
        d = date_s.split('/')[0]
        m = date_s.split('/')[1]
        y = date_s.split('/')[2]
        params[:search][field] = m + '/' + d + '/' + y
      end
    end
  end

  def integerize_money(fields)
    fields.each do |field|
      money_s = params[:search][field]
      unless money_s.blank?
        money_s = money_s.split('.').to_s.split(',').to_s
        params[:search][field] = money_s
      end
    end
  end

  def per_page(quantity)
    if !quantity.blank?
      cookies[:per_page] = {:value => quantity, :expires => 30.days.from_now}
    elsif cookies[:per_page].blank?
      cookies[:per_page] = {:value => "20", :expires => 30.days.from_now} #default 20 per page
    end
    params[:per_page] = cookies[:per_page]
    cookies[:per_page]
  end

  def search_algoritm
    params[:search] = nil if params[:search_clear]
    if params[:search]
      params[:search].each do |param|
        unless param[1].blank?
          @filter_active = true;
          break
        end
      end
    end
  end

  def do_index(model, params, collection = nil, default_order = false, paginate = true, order_by = nil, includes = nil)
    authorize!(:index, model)
    search_algoritm

    if default_order
      @search = model.accessible_by(current_ability, :read).search(params[:search])
    elsif params[:search] && params[:search][:meta_sort]
      @search = model.unscoped.accessible_by(current_ability, :read).search(params[:search])
    elsif order_by
      @search = model.unscoped.order(order_by).accessible_by(current_ability, :read).search(params[:search]) unless includes
      @search = model.unscoped.includes(includes).order(order_by).accessible_by(current_ability, :read).search(params[:search]) if includes
    else
      @search = model.unscoped.order("updated_at DESC, created_at DESC").accessible_by(current_ability, :read).search(params[:search])
    end

    if paginate
      @search.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))
    else
      @search.all
    end
  end

  def prudent_destroy(model, assoc_exceptions = [])
    if model.destroyable?(assoc_exceptions)
      model.destroy
    else
      flash[:warning] = model.errors.full_messages if model.errors.any?
    end

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml { head :ok }
    end
  end


  private ############################################ PRIVATE #################################################

  def after_sign_out_path_for(user)
    new_user_session_path
  end

  rescue_from Exception, :with => :render_500
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/application/access_denied", :alert => t("screens.labels.access_denied")
  end

  def render_404(exception)
    set_content_title(t("screens.errors.not_found_404"))
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render :template => 'errors/not_found', :layout => 'layouts/application', :status => 404 }
      format.all { render :nothing => true, :status => 404 }
    end
  end

  def render_500(exception)
    set_content_title(t("screens.errors.internal_server_error_500"))
    @msg = exception.message + " -- Clase: "
    @backtrace_html = exception.backtrace.join("<br/>")
    backtrace_log = exception.backtrace.join("\n")
    logger.info @msg
    logger.info backtrace_log
    respond_to do |format|
      format.html { render :template => 'errors/internal_server_error', :layout => 'layouts/application', :status => 500 }
      format.all { render :nothing => true, :status => 500 }
    end
    ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver #para que me notifique por mail en production
  end



end
