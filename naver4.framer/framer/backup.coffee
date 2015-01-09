
bg = new Layer 
	x:0, y:0, width:640, height:1136, image:"images/bg.png"

endcard = new Layer x:0, y:600, width:640, height:1001, backgroundColor:'red',image:"images/003.png"
midcard = new Layer x:0, y:600, width:640, height:903, backgroundColor:'blue',image:"images/002.png"
frontcard = new Layer x:0, y:60, width:640, height:1136, backgroundColor:'green',image:'images/001.png'

starty = 0
endy = 0

scrollmode = true

curvemove = 'cubic-bezier(0.4, 0, 0.2, 1)'
curvein = 'cubic-bezier(0, 0, 0.2, 1)'
curveout = 'cubic-bezier(0.4, 0, 1, 1)'

draglayer = new Layer width:640, height:1136, y:1136, backgroundColor:''
draglayer.draggable.enabled = true
draglayer.draggable.speedX = 0

shrink = () ->
	
	frontcard.animate
		properties:
			y:600
			scale:0.98
		curve:curvemove
		time:0.3
	
	midcard.animate
		properties:
			y:414
			scale:0.9
			brightness:98
		curve:curvemove
		time:0.4
		
	endcard.animate
		properties:
			y:230
			scale:0.8
			brightness:95
		curve:curvemove
		time:0.4

	browser.animate
		properties:
			y:-137
		curve:curveout
		time:0.2

	draglayer.y = 0
		
	scrollmode = true
	
expand = () ->
	
	frontcard.animate
		properties:
			y:60
			scale:1
		curve:curvemove	
		time:0.3

	midcard.animate
		properties:
			y:600
			scale:1
			brightness:100
		curve:curvemove
		time:0.3
		
	endcard.animate
		properties:
			y:600
			scale:1
			brightness:100
		curve:curvemove
		time:0.3
	
	browser.animate
		properties:
			y:0
		curve:curvein
		time:0.4
			
	draglayer.y = 1136
		
	scrollmode = false

browser = new Layer 
	x:0, y:0, width:640, height:137, image:"images/browser.png"
	
	
button = new Layer x:550, y:10,backgroundColor:''

button.on Events.Click, ->
	
	if scrollmode is true
		expand()
	else
		shrink()

draglayer.on Events.DragStart,->
	
	starty = event.y
	
draglayer.on Events.DragMove, ->
	
	percentage =  draglayer.y/1135
	percent = percentage.toFixed(2)
	
	frontcard.y = 600+(percent*400)
	midcard.y = 414+(percent*200)
	endcard.y = 230+(percent*30)
	
	midcard.brightness = 98+(percent*20)
	endcard.brightness = 95+(percent*20)
			
draglayer.on Events.DragEnd,->
	endy =  event.y
	delta = starty-endy
	
	if Math.abs(delta) > 10
		if event.y < 640
			shrink()
		else
			expand()
	else
		if event.y > 400
			expand()
		else
			shrink()