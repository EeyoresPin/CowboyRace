extends RigidBody2D

var hatchClosed = true
@onready var anim = $AnimatedSprite2D
@onready var deathTime = $DeathTimer

var detached = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Hatch.set_deferred("disabled", false)
	$HatchOpen.set_deferred("disabled", true)

func _physics_process(delta):
	if detached:
		add_constant_central_force(Vector2(TrainScript.detachForce,0))
		


func closeHatch():
	anim.play("Closed")
	$Hatch.set_deferred("disabled", false)
	$HatchOpen.set_deferred("disabled", true)
	hatchClosed = not hatchClosed

func openHatch():
	anim.play("Open")
	$Hatch.set_deferred("disabled", true)
	$HatchOpen.set_deferred("disabled", false)
	hatchClosed = not hatchClosed


	

func detach():
	detached = true
	deathTime.start()
	
		
		


func _on_lever_area_entered(area):
	if area.name == "BulletHitbox":
		if hatchClosed:
			openHatch()
		else:
			closeHatch()
		var bul = area.get_owner()
		bul.queue_free()


func _on_timer_timeout():
	get_parent().addTrain()
	self.queue_free()
