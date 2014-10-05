class IndexController < ApplicationController
  layout "index_layout"

  def index
    @host = WeddingHost.first

    filter_output
  end


  def filter_output

    @event_date = @host.wedding_date
    countdown = Time.now.to_date.distance_to(@event_date)
    @days_left = countdown[:days]
    @months_left = countdown[:months]
    @years_left = countdown[:years]

     @dateObject = Array.new()

    if (@years_left > 0)
      @dateObject = @dateObject << {:count => @years_left, :label => 'years'}
    elsif (@months_left == 1)
      @dateObject = @dateObject << {:count => @years_left, :label => 'year'}
    end

     if (@months_left > 0)
       @dateObject = @dateObject << {:count => @months_left, :label => 'months'}
     elsif (@months_left == 1)
       @dateObject = @dateObject << {:count => @months_left, :label => 'month'}
     end

     if (@days_left == 1)
       @dateObject = @dateObject << {:count => @days_left, :label => 'day'}
     else
       @dateObject = @dateObject << {:count => @days_left, :label => 'days'}
     end

     if @dateObject.count == 1
       @cssClass = 'col-sm-3'
     elsif @dateObject.count == 2
       @cssClass = 'col-xs-6 col-sm-3'
     elsif @dateObject.count == 3
       @cssClass = 'hidden-xs col-sm-4'
     end

  end
end
