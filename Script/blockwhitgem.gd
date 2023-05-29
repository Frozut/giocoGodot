extends Node2D

@onready var animation := $AnimationPlayer
@onready var coin := $coin
@onready var block_Animation:=$StaticBody2D/Sprite2D

var disable:bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	#controlliamo come semrpe che il body che entra nell'area sia il player 
	if not body is Player: return
	#contrllimao se e` disattivato
	if not disable:
		animation.play("block")
		disable = true
	
	
func delete_Coin() -> void:
	#aggiorniamo le gemme del personaggio 
	Events_and_Var.Gem +=1
	#cambiamo l'animazione 
	block_Animation.play("off")
	#lo facciamo scomparire (forser lo metto a tutti )
	var tween = create_tween()
	tween.tween_property(coin,"modulate:a",0.0,0.5)
	tween.tween_callback(coin.queue_free)
	
