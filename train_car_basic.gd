extends RigidBody2D

var detached = false
@onready var deathTime = $DeathTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if detached:
			add_constant_central_force(Vector2(TrainScript.detachForce,0))
		

func detach():
	detached = true
	deathTime.start()
		
		


func _on_timer_timeout():
	get_parent().addTrain()
	self.queue_free()
