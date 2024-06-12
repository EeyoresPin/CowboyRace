extends CharacterBody2D

@export var player_id = 0


@export var bullet: PackedScene
#@onready var backround = $"/DesertBackround"


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

const timeToMax = 0.75
@export var SPEED = 250.0
const JUMP_VELOCITY = -400.0

@onready var leftGunBarrel = $LeftGunBarrel

@onready var rightGunBarrel = $RightGunBarrel

var resetShot = true
#SLIDING VAR
var sliding = false
const SLIDINGSPEED = 500.0
const SLIDESLOWSPEED = 500.0
var timeSinceSlideStart = 0.0
const SLIDINGSCALEY = 0.5

var beenShot = false
var timeSinceShot = 0.0
const DEFAULTTIMESINCESHOT = 0.75


#var resetJump = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	#
	# Handle jump.
	if Input.get_joy_axis(player_id, JOY_AXIS_TRIGGER_LEFT) > 0.5 and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	
	
	var direction = Input.get_joy_axis(player_id, JOY_AXIS_LEFT_X)
	
	
	#Adds a deadzone in the joystick
	if direction > -0.4 and direction < 0.4:
		direction = 0.0
	
	
	if direction < 0:
		anim.flip_h = true
	elif direction > 0:
		anim.flip_h = false
	
	
	#Handles the sliding input
	if Input.is_joy_button_pressed(player_id, JOY_BUTTON_RIGHT_SHOULDER) and not sliding:
		sliding = true
		timeSinceSlideStart = 0.0
	elif Input.is_joy_button_pressed(player_id, JOY_BUTTON_RIGHT_SHOULDER):
		timeSinceSlideStart += delta
	else:
		sliding = false
		
	
	#Controls sliding physics
	if sliding:
				velocity.x = direction * (SLIDINGSPEED - SLIDESLOWSPEED*timeSinceSlideStart)
				if velocity.x * direction <= 0 :
					#sliding = false
					velocity.x = 0
	#If not sliding controls running physics
	else:
		if direction < 0:
			if velocity.x > -SPEED:
				velocity.x += direction * SPEED/timeToMax * delta
			else:
				velocity.x = -SPEED
		elif direction > 0:	
			if velocity.x < SPEED: 
				velocity.x += direction * SPEED/timeToMax * delta
			else:
				velocity.x = SPEED	
				
		else:	
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#Forces the player to release the trigger
	if (Input.get_joy_axis(player_id, JOY_AXIS_TRIGGER_RIGHT) == 0):
		resetShot = true
	
	
	#SHOOT
	if sliding:
		$CollisionShape2D.scale.y = SLIDINGSCALEY
		anim.play("Slide")
	elif Input.get_joy_axis(player_id, JOY_AXIS_TRIGGER_RIGHT) > 0.5 and resetShot:
		resetShot = false
		shoot()	
		anim.play("Shot")
	else:
		#anim.play("Run")
		pass
		
		
	#Slows the player down if theyve been shot
	if beenShot:
		velocity.x = velocity.x/2
		if not is_on_floor():
			velocity.y = gravity * 2
			
		timeSinceShot += delta
		
		if timeSinceShot >= DEFAULTTIMESINCESHOT:
			timeSinceShot = 0.0
			beenShot = false
			
	move_and_slide()
	

		
	#backround.setOffset(position.x)
	
	
func shoot():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.addTargetIgnore(self)
	if not anim.flip_h:	
		#b.setDirection(deg_to_rad(180.0))
		b.position = self.position + rightGunBarrel.position
		#rightGunBarrel.look_at(get_global_mouse_position())
		#b.setDirection(rightGunBarrel.rotation)
		
	else:
		#b.setDirection(deg_to_rad(0))
		b.position = self.position + leftGunBarrel.position
		#leftGunBarrel.look_at(get_global_mouse_position())
		#b.setDirection(leftGunBarrel.rotation)
		
	var joystick_vector = Vector2(Input.get_joy_axis(player_id, JOY_AXIS_RIGHT_X), Input.get_joy_axis(player_id, JOY_AXIS_RIGHT_Y))
	var joystick_angle = atan2(joystick_vector.y, joystick_vector.x)
	b.setDirection(joystick_angle)
	
	b.addSpeed(Vector2(velocity.x,0))
	
func gotShot():
	velocity.x = 0
	beenShot = true
