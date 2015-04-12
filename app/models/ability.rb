class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    @user = user
    send(@user.role.i18n_name)
  end

  def admin
    can :manage, :all
    cannot_for_everyone
  end

  def gerente
    can :see_port_menu, User
    can :see_cata_menu, User
    can :see_repo_menu, User
    can :manage, Patient
    can :manage, Therapist
    can :manage, Payment
    can :manage, Therapy
    can :manage_therapist_costs, Therapist
    cannot_for_everyone
  end

  def recepcionista
    can :see_port_menu, User
    can :see_cata_menu, User
    can [:read, :update], User, :id => @user.id
    can [:read, :create, :update, :destroy], Patient
    #can :manage, Therapy
    can [:read, :update], Therapist
    can [:read, :create, :destroy], Payment
    can :manage, Service
    can :manage, Cancellation
    can :manage, FixedTherapy
    cannot_for_everyone
  end

  #este metodo es para restringir cosas a nivel negocio, no importa el perfil. Ejemplo: si un Problem esta en estado cerrado NO SE PUEDE EDITAR (sea quien sea el usuario)
  def cannot_for_everyone
    #todo: cannot manage para todas las entidades que son CONSTANT

    cannot :update, Payment
    cannot :update, Cancellation
    cannot :update, Nomina
  end
end
