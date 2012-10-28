class MembershipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    event = Event.find(params[:membership][:event_id])
    event.joined current_user
    flash[:notice] = 'You have joined the Event successfully!'
    redirect_to event_path(event)
  end

  def destroy
    @event = Membership.find(params[:id]).event
    @event.remove_member current_user
    flash[:notice] = 'You have quited the Event successfully!'
    redirect_to event_path(@event)
  end
end
