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
    can :manage, Customer if user.is_sales? || user.is_admin?
    can :manage, SalesInvoice if user.is_sales? || user.is_admin?
    can :manage, Item if user.is_sales? || user.is_admin?

    # Purchaseadmin
    can :manage, Supplier if user.is_purchase? || user.is_admin?
    can :manage, PurchaseOrder if user.is_purchase? || user.is_admin?
    can :manage, Item if user.is_purchase? || user.is_admin?
    can :manage, ManageStock if user.is_purchase? || user.is_admin?

    # user
    can :read, :all if user
    can :edit, User, :id => user.id || user.is_admin?
    can :read, User, :id => user.id || user.is_admin?
    can :update, User, :id => user.id || user.is_admin?
  end
end