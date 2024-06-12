extends ParallaxBackground

var offsetOffset = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	offsetOffset += round(delta * 100)
	scroll_offset.x -= delta * 200.0




func setOffset(pos):
	offset.x = pos 
	

	
	
