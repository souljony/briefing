class HomeController < ApplicationController
  def index
  
  end
  
  def briefing
  
  @aerodromes = params[:aerodromes].split(",")
  @aerodromes.map!(&:upcase)
  
  @aerodromes.each_with_index do |icao, index|
  @metar = Array.new
  openmetar = open("http://weather.noaa.gov/pub/data/observations/metar/stations/#{icao}.TXT")
  @metarquery = openmetar.read
  @metar.push(@metarquery)
  puts @metar.inspect
  end
  
  @aerodromes.each_with_index do |icao, index|
  @taf = Array.new
  opentaf = open("http://weather.noaa.gov/pub/data/forecasts/taf/stations/#{icao}.TXT")  
  @tafquery = opentaf.read
  @taf.push(@tafquery)
  puts @taf.inspect
  end
      
  #opentaf = open("http://weather.noaa.gov/pub/data/forecasts/taf/stations/#{value}.TXT")
  #@taf[value] = opentaf.read

 
   respond_to do |format|
    format.html # show.html.erb
    format.pdf { render :layout => false }
    end
  end
end
#instance_variable_set("@#{variable_name}", :something)