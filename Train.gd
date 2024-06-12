extends Node2D


@export var hitchCarChance = 1.0
@export var basicCarChance = 2.0


@export var hitchCar: PackedScene 
@export var basicCar: PackedScene
var carTypes = Array()
var totalDenom = hitchCarChance + basicCarChance



var cars = Array()
@export var totalActiveCars = 10

var nextTrainLocation = 0.0


var player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	
	carTypes.append([hitchCar, hitchCarChance])
	carTypes.append([basicCar, basicCarChance])
	
	
	for i in range(0,totalActiveCars):
		addTrain()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if player != null:
		detachPastCars()

		
func makeHitchCar():
	var h = hitchCar.instantiate()
	self.add_child(h)
	cars.push_front(h)
		
	h.position.x = nextTrainLocation
	h.position.y = 189.0
	#h.set_sync_to_physics(true)
	nextTrainLocation += 189.0
	

func makeBasicCar():
	var h = basicCar.instantiate()
	self.add_child(h)
	cars.push_front(h)
		
	h.position.x = nextTrainLocation
	h.position.y = 189.0
	#h.set_sync_to_physics(true)
	
	nextTrainLocation += 190.0
	
	
	
func detachPastCars():
	for c in cars:
			if player.position.x > c.position.x:
				print(c.name)
				c.detach()
				cars.pop_back()
				
		
func setPlayerFirst(newPlayer):
	player = newPlayer


func addTrain():
	var carChoice = randf() * totalDenom		
	if carChoice < hitchCarChance:
		makeHitchCar()
	elif carChoice < basicCarChance + hitchCarChance:			
		makeBasicCar()
	
