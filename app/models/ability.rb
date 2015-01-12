class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :manage, :all if user.has_role? :admin

    can :read, [Artist, Message, Movie]
    if user.id? # user is signed in?
      can :manage, Message, sender_id: user.id
      can :read, Scout
      can :read, User
      can :manage, User, id: user.id
      if user.artist
        can :manage, Artist, id: user.artist.id
        can :manage, Message, artist_id: user.artist.id
        can :manage, Movie,   artist_id: user.artist.id
      elsif user.scout
        can :manage, Scout, id: user.scout.id
        can :read, :rankings
      else 
        can :create, Artist
        can :create, Scout
      end
    else
      can :create, User
    end
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
