extends Area2D


func _on_body_entered(body):
	if body is Player:
		#serve per resettare la scena come è all'inizio
		get_tree().reload_current_scene()
