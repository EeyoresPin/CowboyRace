extends StaticBody2D

var hatchClosed = true
@onready var anim = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Hatch.set_deferred("disabled", false)
	$HatchOpen.set_deferred("disabled", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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


	
			
		
		


func _on_lever_area_entered(area):
	if area.name == "BulletHitbox":
		if hatchClosed:
			openHatch()
		else:
			closeHatch()
		var bul = area.get_owner()
		bul.queue_free()
