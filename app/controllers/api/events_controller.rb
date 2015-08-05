class Api::EventsController < ApplicationController
  before_filter :set_access_control_headers

  def set_access_control_headers
    #Allow request from any origin
    headers['Access-Control-Allow-Origin'] = '*'
    # Permit the POST,GET, OPTION request methods
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    # Allow the header Content-Type that declare the data type being sent
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end

  skip_before_action :verify_authenticity_token
   # necessary in all controllers that will respond with JSON
  respond_to :json

  def create
    registered_application = App.find_or_create_by(url: request.env['HTTP_ORIGIN'])
    @event = registered_application.events.find_by(event_params)
    if @event == nil
      @event = registered_application.events.build(event_params)
      @event.count = 1
      if @event.save
        render json: @event, status: :created
      else
        render json: "Broken event", status: :unprocessable_entity
      end
    else
      @event.count += 1
      if @event.save
        render json: @event, status: :created
      else
        render json: "Broken event", status: :unprocessable_entity
      end
    end
  end

  private
  # Error responses and before_action blocking work differently with Javascript requests.
  # Rather than using before_actions to authenticate actions, we suggest using
  # "guard clauses" like `permission_denied_error unless condition`
    def event_params
       params.require(:event).permit(:name)
    end

  def permission_denied_error
    error(403, 'Permission Denied!')
  end

  def error(status, message = 'Something went wrong')
    response = {
      response_type: "ERROR",
      message: message
  }

  render json: response.to_json, status: status
  end
end
