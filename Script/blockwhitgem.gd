extends Node2D



@onready var animation := $AnimationPlayer
@onready var coin := $coin
@onready var block_Animation:=$StaticBody2D/Sprite2D

var disable:bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is Player: return
	if not disable:
		animation.play("block")
		disable = true
	
	

func delete_Coin() -> void:
	Events_and_Var.Gem +=1
	block_Animation.play("off")
	coin.queue_free()
