extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

func _on_body_entered(body):
	if not body is Player : return
	animated_sprite.play("checked") 
	Events_and_Var.emit_signal("hit_checkpoint",position)
