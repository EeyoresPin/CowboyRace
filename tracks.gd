extends Node

@export var rail: PackedScene
var positionOfNextTrack = -200
@export var tracksToMake = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(tracksToMake):
		makeTrack()



func makeTrack():
	var r = rail.instantiate()
	self.add_child(r)
	r.position.x = positionOfNextTrack
	r.position.y = 250
	positionOfNextTrack += 480.0
