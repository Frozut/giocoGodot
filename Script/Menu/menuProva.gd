extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _on_start_button_pressed() -> void:
	Utils.load_game()
	Transition.play_exit_transition()
	#grazie a questo comando mettimano il gioco in pausa
	get_tree().paused = true 
	#con questo comanto aspettimao finche il segnale che abbimao creato venga emesso 
	await Transition.animation_completed
	#faccimao partire l'aniamzione di entrata
	Transition.play_enter_transition()
	#togliamo il gioco dalla pausa
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://Livelli/TrueLevels/Level1.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
