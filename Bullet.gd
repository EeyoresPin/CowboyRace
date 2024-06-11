extends RigidBody2D


var direction = 1
const SPEED = 900

var targetIgnore = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	#lock_rotation = true
	pass


	
func _physics_process(delta):
	#apply_central_force(Vector2(1,0).rotated(self.rotation) * SPEED)
	pass

func addTargetIgnore(body):
	targetIgnore.append(body)

func addSpeed(givenSpeed):
	#add_central_force(givenSpeed)
	pass

func setDirection(givenRotation):
	
	self.rotation = givenRotation
	apply_central_force(Vector2(1,0).rotated(self.rotation) * SPEED)


func _on_hitbox_body_entered(body):
	#print(body.name)
	if body.name == "CowboyBasic" and not targetIgnore.has(body):
		#print("HIT Player")
		body.gotShot()
		self.queue_free()
	elif not targetIgnore.has(body):
		#print("HIT WALL")
		self.queue_free()
	else:
		#print("IGNORE")
		pass
		
