module ApplicationHelper

  #metodo recursivo para print cosas como @city.region_state.country.name  si alguno de los objetos intermedio es nil entonces devuelve "", sino devuelve el valor. sirve en los listados cuando los campos no son requeridos
  def print_attribute(object, methods, attribute = "name")
    unless methods.empty?
      if result = object.send(methods.shift)
        print_attribute(result, methods, attribute)
      else
        return ""
      end
    else
      return object.send(attribute)
    end
  end

  def avatar_url(user)
#    if user.avatar_url.present?
#      user.avatar_url
#    else
      default_url = "#{root_url}images/guest_user.gif"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
#    end
  end

  def major_currencies(hash)
    hash.inject([]) do |array, (id, attributes)|
      priority = attributes[:priority]
      if priority && priority < 10
        array ||= []
        array << [attributes[:name], attributes[:iso_code]]
      end
      array
    end
  end

  def all_currencies(hash)
    hash.inject([]) do |array, (id, attributes)|
      array ||= []
      array << [attributes[:name], attributes[:iso_code]]
      array
    end
  end

  def handle_nested_models_errors(model_instance)
    #return unless model_instance && model_instance.errors.any?

    nested_model_messages = Array.new
    model_instance.errors.each do |error|
      #obtener solo los errores de los nested models
      model_chain = error[0].to_s.split(".")
      if model_chain.size > 1
         nested_model_messages << t("activerecord.models." + model_chain[model_chain.size - 2].to_s.camelize) + ": " + t("activerecord.attributes." + model_chain[model_chain.size - 2].to_s.underscore.singularize + "." + model_chain[model_chain.size - 1].to_s) + " " + error[1].to_s
      end
    end
    nested_model_messages
  end

  def creating?
    ["new", "create"].include?(action_name)
  end

  def updating?
    ["edit", "update"].include?(action_name)
  end

  def listing?
    action_name == "index"
  end

  def showing?
    action_name == "show"
  end


  #model_or_relation: no tiene sentido enviar un model (ej: LifeCycle) porque cuando se haga .all obviamente contendra al actual
  #attribute_name es el atributo con el cual sera sort la collection
  def collection_with_actual(model_or_relation, actual = nil, attribute_name = :name, sortable = true)
    collection = model_or_relation     if model_or_relation.class == Array
    collection = model_or_relation.all unless model_or_relation.class == Array

    if actual.respond_to?(:each) #si envio un array de valores actuales, como en relaciones many_to_many como la del project_dashboard con users
      actual.each do |act|
        collection << act if !collection.include?(act)
      end
      if sortable
        if actual.respond_to?(:downcase)
          collection.sort! { |a, b| a.try(attribute_name).downcase <=> b.try(attribute_name).downcase }
        else
          collection.sort! { |a, b| a.try(attribute_name) <=> b.try(attribute_name) }
        end
      end
    elsif actual && !collection.include?(actual)
      collection << actual
      if sortable
        if actual.respond_to?(:downcase)
          collection.sort! { |a, b| a.try(attribute_name).downcase <=> b.try(attribute_name).downcase }
        else
          collection.sort! { |a, b| a.try(attribute_name) <=> b.try(attribute_name) }
        end
      end
    end

    return collection
  end

  def decimal_to_percentage(decimal)
    decimal * 100
  end



  def menu
    if !session[:menu]
      ini = "htmlMenu: \""
      port = "<div class=\\\"voice {panel:'/menus/portafolio.html'}\\\"><span class='label'><img src='/images/glyphicons/white/glyphicons_341_briefcase_white.png' alt=''/>#{t('screens.menu.portfolio')}</span></div>"
      cata = "<div class=\\\"voice {panel:'/menus/catalogs.html'}\\\"><span class='label'><img src='/images/glyphicons/white/glyphicons_351_book_open.png' alt=''/>#{t('screens.menu.catalogs')}</span> </div>"
      repo = "<div class=\\\"voice {panel:'/menus/reports.html'}\\\"><span class='label'><img src='/images/glyphicons/white/glyphicons_029_notes_2.png' alt=''/>#{t('screens.menu.reports')}</span> </div>"
      admi = "<div class=\\\"voice {panel:'/menus/administration.html'}\\\"><span class='label'><img src='/images/glyphicons/white/glyphicons_023_cogwheels.png' alt=''/>#{t('screens.menu.administration')}</span></div>"
      fin = "\","

      menu = ini + ((can? :see_port_menu, User) ? port : "") +
            ((can? :see_cata_menu, User) ? cata : "") +
            ((can? :see_repo_menu, User) ? repo : "") +
            ((current_user.admin?) ? admi : "") +
            fin
      session[:menu] = menu
    end
    return session[:menu]
  end

  def menuItems
    if session[:menu_items]
      menuItems = current_user.html_menu_items #lo guardo en el user porque no puedo ponerlo en session, supera los 4K permitidos
    else
      menuItems =
            "
            portItems:{
                       main: #{(can? :see_port_menu, User) ? "true" : "false"},
                       pendings: 'true',
                        html_pendings: '<div>#{link_to(t("screens.menu.port.pendings"), root_path, :class => 'ajax')}</div>',
                       presences_today: 'true',
                        html_presences_today: '<div>#{link_to(t("screens.menu.port.presences_today"), "/presences/today_sessions", :class => 'ajax')}</div>',
                       services: 'true',
                        html_services: '<div>#{link_to(t("screens.menu.port.services"), services_path, :class => 'ajax')}</div>',
                       fixed_therapies: 'true',
                        html_fixed_therapies: '<div>#{link_to(t("screens.menu.port.fixed_therapies"), fixed_therapies_path, :class => 'ajax')}</div>'
                      },

            cataItems:{
                       main: #{(can? :see_cata_menu, User) ? "true" : "false"},
                       patients: 'true',
                        html_patients: '<div>#{link_to(t("screens.menu.cata.patients"), patients_path, :class => 'ajax')}</div>',
                       therapists: 'true',
                        html_therapists: '<div>#{link_to(t("screens.menu.cata.therapists"), therapists_path, :class => 'ajax')}</div>',
                       payments: 'true',
                        html_payments: '<div>#{link_to(t("screens.menu.cata.payments"), payments_path, :class => 'ajax')}</div>',
                       presences: 'true',
                        html_presences: '<div>#{link_to(t("screens.menu.cata.presences"), presences_path, :class => 'ajax')}</div>'
                      },

            repoItems:{
                       main: #{(can? :see_repo_menu, User) ? "true" : "false"}
                      },
            admiItems:{
                       main: #{(current_user.admin?) ? "true" : "false"},
                       html_users: '<div>#{link_to(t("screens.menu.admi.users"), users_path, :class => 'ajax')}</div>'
                      },"
      current_user.update_attribute(:html_menu_items, menuItems) #lo guardo en el user porque no puedo ponerlo en session, supera los 4K permitidos
      session[:menu_items] = true
    end
    return menuItems
  end


  def find_chars(string1, string2)
    puts "hola"
  end
end
