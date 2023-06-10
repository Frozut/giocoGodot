extends Area2D



@export var bounce_force = -200
@onready var animation :AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:return
	var player = body
	if not player.is_on_floor():
		animation.play("boing")
		body.velocity.y =bounce_force
		if body.DOUBLE_JUMP == 0: body.DOUBLE_JUMP+=1
		
