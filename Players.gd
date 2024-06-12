extends Node2D


var players = Array()
@onready var camera = $"../WorldCamera"
@onready var train = $"../Train"

# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	players.sort_custom(sortByPosition)
	camera.setPosition(players[0].position.x)
	
	
	train.setPlayerFirst(players[0])
	
	
	
func sortByPosition(a,b):
	if a.position.x > b.position.x:
		return true
	else:
		return false


