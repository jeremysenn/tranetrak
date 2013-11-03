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

    user ||= User.new # guest user (not logged in)

    # Admin User
      ############
    if user.has_role? :admin
      can :manage, :all
#    elsif user.admin?
#      # Databases
#      ############
#      can :manage, Database do |db|
#        db.company_id == user.company_id
#      end
#      can :create, Database
#
#      # Users
#      ############
#      can :manage, User do |u|
#        u.company_id == user.company_id
#      end
#      can :create, User
    else
#      can :read, :all

      # Users
      ############
      can :manage, User do |u|
        u.id == user.id
      end
      cannot :index, User

      # Clients
      ############
      if user.is_trainer?
        can :manage, Client do |c|
          c.trainer == user.trainer
        end
        can :create, Client
      end
      if user.is_client?
        can :read, Client do |c|
          c.user == user
        end
      end

      # Bodycomps
      ############
      if user.is_trainer?
        can :manage, Bodycomp do |b|
          b.client.trainer == user.trainer
        end
        can :create, Bodycomp do |bc|
          user.subscription.plan.stripe_plan_id == 10 or user.subscription.plan.stripe_plan_id == 12
        end
      end
      if user.is_client?
        can :read, Bodycomp do |b|
          b.client == user.client
        end
      end

      # Workout_sessions
      ############
      if user.is_trainer?
        can :manage, WorkoutSession do |ws|
          ws.trainer == user.trainer
        end
        can :create, WorkoutSession do |ws|
          user.subscription.plan.stripe_plan_id == 11 or user.subscription.plan.stripe_plan_id == 12
        end
      end
      if user.is_client?
        can :read, WorkoutSession do |ws|
          ws.client == user.client
        end
      end

      # Subscriptions
      ############
      can :manage, Subscription do |s|
        s.user_id == user.id
      end
      cannot :index, Subscription
      can :create, Subscription

      # Plans
      ############
      can :index, Plan

    end

  end
end
