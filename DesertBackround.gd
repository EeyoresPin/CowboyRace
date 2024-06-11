extends ParallaxBackground

var offsetOffset = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	offsetOffset += round(delta * 4)
	offset.x = offset.x + offsetOffset




func setOffset(pos):
	offset.x = pos
