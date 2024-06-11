extends CharacterBody2D

@export var player_id = 0


@export var bullet: PackedScene
@onready var backround = $"../DesertBackround"


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

const timeToMax = 0.75
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var leftGunBarrel = $LeftGunBarrel

@onready var rightGunBarrel = $RightGunBarrel



#SLIDING VAR
var sliding = false
const SLIDINGSPEED = 500.0
const SLIDESLOWSPEED = 500.0
var timeSinceSlideStart = 0.0
const SLIDINGSCALEY = 0.5



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_joy_button_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("LEFT", "RIGHT")
	
	if direction == -1:
		anim.flip_h = true
	elif direction == 1:
		anim.flip_h = false
	
	if Input.is_action_just_pressed("SLIDE"):
		sliding = true
		timeSinceSlideStart = 0.0
	elif Input.is_action_pressed("SLIDE"):
		timeSinceSlideStart += delta
	else:
		sliding = false
		
	

	if sliding:
				velocity.x = direction * (SLIDINGSPEED - SLIDESLOWSPEED*timeSinceSlideStart)
				if velocity.x * direction <= 0 :
					#sliding = false
					velocity.x = 0
	else:
		if direction == -1:
			if velocity.x > -SPEED:
				velocity.x += direction * SPEED/timeToMax * delta
			else:
				velocity.x = -SPEED
		elif direction == 1:	
			if velocity.x < SPEED: 
				velocity.x += direction * SPEED/timeToMax * delta
			else:
				velocity.x = SPEED	
				
		else:	
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	#SHOOT
	if sliding:
		$CollisionShape2D.scale.y = SLIDINGSCALEY
		anim.play("Slide")
	elif Input.is_action_just_pressed("SHOOT"):
		shoot()	
		anim.play("Shot")
	else:
		#anim.play("Run")
		pass
		
		
		
	move_and_slide()
	

		
	backround.setOffset(position.x)
	
	
func shoot():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.addTargetIgnore(self)
	if not anim.flip_h:	
		#b.setDirection(deg_to_rad(180.0))
		b.position = self.position + rightGunBarrel.position
		rightGunBarrel.look_at(get_global_mouse_position())
		b.setDirection(rightGunBarrel.rotation)
	else:
		#b.setDirection(deg_to_rad(0))
		b.position = self.position + leftGunBarrel.position
		leftGunBarrel.look_at(get_global_mouse_position())
		b.setDirection(leftGunBarrel.rotation)
	
	b.addSpeed(Vector2(velocity.x,0))
	
func gotShot():
	print("GOT SHOT")
