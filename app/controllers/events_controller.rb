class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  

  # GET /events
  # GET /events.json
  def index
    monthrender
  end

  # GET /events/1
  # GET /events/1.json
  def show
    
  end

  # GET /events/new
  def new
    @event = Event.new
        respond_to do |format|
        format.html {  }
        format.js { render 'events/_jsform' }
      
    end
    
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.participants << Participant.find(current_user.id)
    respond_to do |format|
      if @event.save
        monthrender
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
        format.js { render action: 'create' }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  
  def events_by_day
    @events = Event.where('extract(month from eventdate) = ? AND extract(day from eventdate) = ?', params[:date].to_datetime.month, params[:date].to_datetime.day)
    @date = params[:date]
    respond_to do |format|
      format.html {  }
      format.json { head :no_content }
      format.js {  }
    end    
  end
  
  def new_with_date
    @event = Event.new
    @date = params[:date]
        respond_to do |format|
        format.html {  }
        format.js {  }
      
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :eventdate, :text, :date, :participant_ids => []) if params[:event]
    end
    
    def monthrender
      @events = Event.all
      @events_by_date = @events.group_by { |m| m.eventdate.to_datetime.beginning_of_day }
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
    end
end