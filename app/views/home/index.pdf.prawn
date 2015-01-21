# Assign the path to your file name first to a local variable.
logopath = "#{RAILS_ROOT}/public/images/logo.png"
 
# Displays the image in your PDF. Dimensions are optional.
pdf.image logopath, :width => 248, :height => 106

pdf.move_down 70

# Add the font style and size
pdf.font "Helvetica"
pdf.font_size 18
pdf.text_box "Briefing for # #{ @aerodromes.all }", :align => :right
 
pdf.font_size 14
pdf.text "Below you can find your order details. We hope you shop with Awesome Company again in the future. Now unleash those fonts like hell have no fury!", :align=> :center