class UsersController < ApplicationController
  load_and_authorize_resource :except => [:index, :create]

  def index
    @users = do_index(User, params, false, true) #el true es para que use el default_scope de User, el cual no muestra al superuser

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user }
    end
  end

  def new
    @user.state = State.active

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user }
    end
  end

  def edit
  end

  def create
    pass = (0..10).map{ ('a'..'z').to_a[rand(26)] }.join
    params[:user][:password] = pass
    params[:user][:password_confirmation] = pass
    @user = User.new(params[:user])
    authorize! :create, @user

    respond_to do |format|
      if @user.save
        #UserMailer.registration_confirmation(@user).deliver
        @user.send_reset_password_instructions
        format.html { redirect_to(users_path, :notice => t("devise.labels.new_user_email_sent", :email => @user.email)) }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user.attributes = params[:user]

    respond_to do |format|
      if @user.save
        format.html {
          redirect_to(root_path, :notice => t("screens.notice.successfully_updated")) if cannot? :read, @user
          redirect_to(@user, :notice => t("screens.notice.successfully_updated")) if !current_user.admin?
          redirect_to(users_path, :notice => t("screens.notice.successfully_updated")) if current_user.admin?
        }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    prudent_destroy(@user)
  end

  def resend_password_instructions
    @user = User.find(params[:id])
    @user.send_reset_password_instructions
    redirect_to(users_path, :notice => t("devise.labels.new_user_email_sent", :email => @user.email))
  end


end
