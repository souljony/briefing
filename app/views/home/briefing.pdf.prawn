require "open-uri"
Prawn::Document.new(:page_size => "A4")
# Assign the path to your file name first to a local variable.
logopath = ::Rails.root.join('public','images','logo.jpg')
pdf.font "Courier"
 
Time.zone = 'Lisbon'
# Displays the image in your PDF. Dimensions are optional.
pdf.image logopath, :width => 248, :height => 106, :scale => 0.5
pdf.font_size 10
pdf.text_box "Leávia Student Briefing Document \n\n Incluides Weather Information and NOTAMs for the following aerodromes: #{params[:aerodromes].upcase}. \n Generated at #{Time.zone.now}.", :style => :bold, :align => :left, :at => [160, 720]
pdf.move_down 10

# Add the font style and size
pdf.font "Courier"
pdf.font_size 9
pdf.text "ALWAYS confirm if the information here is up to date!", :align => :center, :style => :bold
 
pdf.move_down 20

pdf.font_size 30
pdf.text "Weather Information", :style => :bold, :align => :center
pdf.move_down 10

@aerodromes.each_with_index do |icao, index|
pdf.font_size 18
pdf.text "METAR for #{icao}", :style => :bold
pdf.font_size 12
begin
openmetar = open("http://weather.noaa.gov/pub/data/observations/metar/stations/#{icao}.TXT")
pdf.text openmetar.read
rescue
pdf.text ">> METAR is not available! <<"
end
pdf.move_down 5
pdf.font_size 18
pdf.text "TAF for #{icao}", :style => :bold
pdf.font_size 12
begin
opentaf = open("http://weather.noaa.gov/pub/data/forecasts/taf/stations/#{icao}.TXT")
pdf.text opentaf.read
rescue
pdf.text ">> TAF is not available! <<"
end
pdf.move_down 15
end

pdf.start_new_page(:size => "A4", :layout => :landscape, :margin => 5)
case @time
when "0"
image open("http://brunnur.vedur.is/flugkort/PPVE89_EGRR_0000.png"), :scale => 0.95 
when "1"
image open("http://brunnur.vedur.is/flugkort/PPVE89_EGRR_0600.png"), :scale => 0.95 
when "2"
image open("http://brunnur.vedur.is/flugkort/PPVE89_EGRR_1200.png"), :scale => 0.95 
when "3"
image open("http://brunnur.vedur.is/flugkort/PPVE89_EGRR_1800.png"), :scale => 0.95 
end

pdf.start_new_page
case @time
when "0"
image open("http://brunnur.vedur.is/flugkort/vindakort/eur_FL050_0000.png"), :scale => 0.93
when "1"
image open("http://brunnur.vedur.is/flugkort/vindakort/eur_FL050_0600.png"), :scale => 0.93
when "2"
image open("http://brunnur.vedur.is/flugkort/vindakort/eur_FL050_1200.png"), :scale => 0.93
when "3"
image open("http://brunnur.vedur.is/flugkort/vindakort/eur_FL050_1800.png"), :scale => 0.93
end

pdf.start_new_page(:size => "A4", :layout => :landscape, :margin => 1)
case @time
when "0"
image open("http://brunnur.vedur.is/flugkort/PGDE14_EGRR_0000.PNG"), :scale => 0.85
when "1"
image open("http://brunnur.vedur.is/flugkort/PGDE14_EGRR_0600.PNG"), :scale => 0.85
when "2"
image open("http://brunnur.vedur.is/flugkort/PGDE14_EGRR_1200.PNG"), :scale => 0.85
when "3"
image open("http://brunnur.vedur.is/flugkort/PGDE14_EGRR_1800.PNG"), :scale => 0.85
end

pdf.start_new_page(:size => "A4", :layout => :portrait, :margin => 30)
pdf.font_size 30
pdf.text "NOTAM Information", :style => :bold, :align => :center
pdf.move_down 5
@aerodromes.each_with_index do |icao, index|
pdf.font_size 22
pdf.move_down 20
pdf.text "NOTAMS for #{icao}", :style => :bold
pdf.font_size 12
if icao.notams.blank?
pdf.text ">> There are no NOTAMs! <<"
end
icao.notams.each do |texto|
pdf.text texto
end
end

pdf.move_down 25
pdf.text ">> END OF DOCUMENT <<", :align => :center, :style => :bold

options = {
        :at => [pdf.bounds.right - 150, 0],
        :width => 150,
        :align => :right,
        :start_count_at => 1
}
pdf.number_pages "Page <page> of <total>", options