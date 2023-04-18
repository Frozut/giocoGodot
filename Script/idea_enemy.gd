extends CharacterBody2D

enum {MOVING,STOP}
var state = MOVING

@onready var animation := $AnimatedSprite2D
@onready var timer := $Timer
@onready var jump_area := $"Area no damage/CollisionShape2D"  
@onready var hitbox_Collision := $Hitbox
var direction :=Vector2.RIGHT
	
	
	
func _ready() -> void:
	timer.start(5)

func _physics_process(delta: float) -> void:
	match state:
		MOVING: moving_state()
		STOP: stop_state()

func moving_state()-> void:
	jump_area.disabled = true
	animation.play("walking")
	var found_wall :bool= is_on_wall()
	if found_wall:
		direction *= -1
		if animation.flip_h==false:
			animation.flip_h=true
		else:
			animation.flip_h=false
	velocity = direction*25
	move_and_slide()
	

func stop_state()-> void :
	jump_area.disabled = false
	animation.play("stop")
	await timer.timeout
	state = MOVING
	timer.start(5)


func _on_area_no_damage_body_entered(body: Node2D) -> void:
	if not body is Player: return
	if hitbox_Collision.overlaps_body(body): return
	var player:= body
	#richiama il metodo del player che permette di saltare sopra al nemico e ucciderlo
	player.jump_on_bonch_enemy()
	queue_free()


func _on_timer_timeout() -> void:
	state = STOP
	timer.start(1.00)
	
	
