# frozen_string_literal: true

class CalendarReflex < ApplicationReflex
  def new_calendar_event
    @calendar_event = CalendarEvent.new(session_id: session.id, occurs_at: Date.parse(element.dataset['date']))
    session[:calendar_event_attributes] = @calendar_event.attributes

    morph '#calendar-event-modal', ApplicationController.render(partial: '/calendars/calendar_event_modal', locals: { calendar_event: @calendar_event })
  end

  def edit_calendar_event
    @calendar_event = CalendarEvent.find(element.dataset[:id])

    morph '#calendar-event-modal', ApplicationController.render(partial: '/calendars/calendar_event_modal', locals: { calendar_event: @calendar_event })
  end

  def destroy_calendar_event
    CalendarEvent.find(element.dataset[:id]).destroy
  end

  def close_calendar_event
    morph '#calendar-event-modal', ''
  end

  def validate_calendar_event
    @calendar_event = CalendarEvent.where(id: element.dataset[:id]).first_or_initialize(session_id: session.id, occurs_at: Date.parse(element.dataset['date']))
    @calendar_event.description = element[:value]
    @calendar_event.validate

    morph '#calendar-event-modal', ApplicationController.render(partial: '/calendars/calendar_event_modal', locals: { calendar_event: @calendar_event })
  end
end
