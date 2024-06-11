extends Camera2D

#@onready var backround = $"../DesertBackround"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setPosition(newPosX):
	self.position.x =  newPosX
	#backround.setOffset(self.position.x)
