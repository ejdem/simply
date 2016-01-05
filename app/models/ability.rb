class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.role?(:admin)
      can :manage, :all
    elsif user.role?(:moderator)
      can [:create, :read, :update], Project
      can :read, Project
    elsif user.role?(:user)
      can :read, Project
    end
  end
end
