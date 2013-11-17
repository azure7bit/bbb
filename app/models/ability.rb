class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    alias_action :read, :new, :create, :edit, :update, :to => :modify
    user ||= User.new { |u| u.id = -1 } # guest user (not logged in)
    
    # Superadmin
    can :manage, :all if user.is_admin?

    # Salesadmin
    can :manage, Customer if user.is_admin? || user.is_sales?

    # Purchaseadmin
    can :manage, Supplier if user.is_admin? || user.is_purchase?

    # user
    can :edit, User, :id => user.id
    can :read, User, :id => user.id
    can :update, User, :id => user.id
  end
end
