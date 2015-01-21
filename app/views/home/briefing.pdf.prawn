require "open-uri"
Prawn::Document.new(:page_size => "A4")
# Assign the path to your file name first to a local variable.
logopath = ::Rails.root.join('public','images','logo.jpg')
pdf.font "Courier"
 
# Displays the image in your PDF. Dimensions are optional.
pdf.image logopath, :width => 248, :height => 106, :scale => 0.5
pdf.font_size 30
pdf.text_box "Briefing", :style => :bold, :align => :center, :at => [200, 700]
pdf.move_down 10

# Add the font style and size
pdf.font "Courier"
pdf.font_size 9
pdf.text "This briefing contains information for the following aerodromes: #{params[:aerodromes]}. Always confirm if the information here is up to date!", :align => :left
 
pdf.move_down 20

pdf.font_size 30
pdf.text "Weather Information", :style => :bold, :align => :center
pdf.move_down 10

@aerodromes.each_with_index do |icao, index|
pdf.font_size 18
pdf.text "METAR for #{icao}", :style => :bold
pdf.font_size 12
openmetar = open("http://weather.noaa.gov/pub/data/observations/metar/stations/#{icao}.TXT")
pdf.text openmetar.read
pdf.move_down 5
pdf.font_size 18
pdf.text "TAF for #{icao}", :style => :bold
pdf.font_size 12
opentaf = open("http://weather.noaa.gov/pub/data/forecasts/taf/stations/#{icao}.TXT")
pdf.text opentaf.read
pdf.move_down 15
end

pdf.start_new_page(:size => "A4", :layout => :landscape, :margin => 5)
image open("http://brunnur.vedur.is/flugkort/PPVE89_EGRR_1200.png"), :scale => 0.95 

pdf.start_new_page
image open("http://brunnur.vedur.is/flugkort/vindakort/eur_FL050_1200.png"), :scale => 0.93

pdf.start_new_page(:size => "A4", :layout => :landscape, :margin => 1)
image open("http://brunnur.vedur.is/flugkort/PGDE14_EGRR_1200.PNG"), :scale => 0.85

pdf.start_new_page(:size => "A4", :layout => :portrait, :margin => 30)
pdf.font_size 30
pdf.text "NOTAM Information", :style => :bold, :align => :center
pdf.move_down 5
@aerodromes.each_with_index do |icao, index|
pdf.font_size 22
pdf.move_down 20
pdf.text "NOTAMS for #{icao}", :style => :bold
icao.notams.each do |texto|
pdf.font_size 12
pdf.text texto
end
end

options = {
        :at => [pdf.bounds.right - 150, 0],
        :width => 150,
        :align => :right,
        :start_count_at => 1
}
pdf.number_pages "Page <page> of <total>", options