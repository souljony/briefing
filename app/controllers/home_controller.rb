class HomeController < ApplicationController
  def index
  
  end
  
  def briefing
  
  @aerodromes = params[:aerodromes].split(",")
  @aerodromes.map!(&:upcase)
  
  @time = params[:time]
  
  @aerodromes.each_with_index do |icao, index|
  @metar = Array.new
  begin
  openmetar = open("http://weather.noaa.gov/pub/data/observations/metar/stations/#{icao}.TXT")
  @metarquery = openmetar.read
  @metar.push(@metarquery)
  puts @metar.inspect
  rescue
  end
  end
  
  @aerodromes.each_with_index do |icao, index|
  @taf = Array.new
  begin
  opentaf = open("http://weather.noaa.gov/pub/data/forecasts/taf/stations/#{icao}.TXT")  
  @tafquery = opentaf.read
  @taf.push(@tafquery)
  puts @taf.inspect
  rescue
  end
  end
      
  #opentaf = open("http://weather.noaa.gov/pub/data/forecasts/taf/stations/#{value}.TXT")
  #@taf[value] = opentaf.read

   end
end
#instance_variable_set("@#{variable_name}", :something)