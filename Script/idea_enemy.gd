extends Node2D

enum {MOVING,STOP}
var state = MOVING

@onready var animation = $AnimatedSprite2D

func _process(delta: float) -> void:
	match state:
		MOVING: moving_state()
		STOP: stop_state()



func moving_state()-> void:
	pass

func stop_state()-> void :
	pass


func _on_area_no_damage_body_entered(body: Node2D) -> void:
	print(body)
	if not body is Player: return
	var player:= body
	#richiama il metodo del player che permette di saltare sopra al nemico e ucciderlo
	player.jump_on_bonch_enemy()
	queue_free()
