extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const GRAVITY = 4
var velocity = Vector2.ZERO


func _physics_process(delta):
	
	apply_gvavity()
	var input =Vector2.ZERO 
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x == 0:
		applay_friction()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = 50
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -50;
	else:
		velocity.x = 0
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y=-100
		
	velocity = move_and_slide(velocity,Vector2.UP)

func apply_gvavity():
	velocity.y += GRAVITY
	
func applay_friction():
	pass
