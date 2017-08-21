class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    if user
      user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :index, Calendar
  end

  def user_abilities
    guest_abilities
    can :read, Calendar, user_id: @user.id
    can :read, Event do |event|
      @user.calendars.last.id == event.calendars.find(@user.calendars.last.id).try(:id)
    end
    can :create, [Calendar, Event]
    can :update, Event, user_id: @user.id
    can :destroy, Event, user_id: @user.id
    can :share, Event, user_id: @user.id
  end
end
