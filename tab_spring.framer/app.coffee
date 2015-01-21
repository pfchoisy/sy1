screenX = Framer.Device.screen.width
screenY = Framer.Device.screen.height

bg = new BackgroundLayer 
	backgroundColor: "#2DD7AA" 
	


layerWidths = [100, 150, 200, 150, 100, 150, 200, 150, 100]

totalWidth = layerWidths.reduce (a, b) -> 
	a + b + 2
print totalWidth

menuLayer = new Layer
	x:0, y:0, width:totalWidth, height:100

# menuLayer.scrollHorizontal = true

start = 0
for w, i in layerWidths
	sublayer = new Layer
		x:start, y:0, width:w, height:100, superLayer: menuLayer
		
	sublayer.backgroundColor = "#FFFFFF"
	sublayer.scrollHorizontal = true
	sublayer.html = w + "(" + i + ")"
	sublayer.style["color"] = "#000000"
	start += w + 2

menuLayer.draggable.enabled = true
menuLayer.draggable.speedY = 0

menuLayer.on Events.DragMove, (event, layer) ->
	if layer.x > 0
		layer.x = 0
		
	if layer.x < -totalWidth + 640
		layer.x = -totalWidth + 640

menuLayer.on Events.DragEnd, (event, layer) ->
	scrollX = -layer.x	
	center = scrollX + 320	
	start = 0;
	
	for w, i in layerWidths
		if start <= center && start + w >= center
			print "center item : ", i
			menuLayer.x = -start + 320 - w / 2;
			
			bar.width = w;
			bar.x = 320 - w / 2;
			break
			
		start += w + 2 

bar = new Layer({width:208, height:10})
bar.backgroundColor = "red"
bar.backgroundColor = "#00a47d"
bar.x = 211
bar.y = 250