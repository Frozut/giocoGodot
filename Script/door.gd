extends Area2D

@export_file("*.tscn") var target_level_path: String 

var player:Player

func _process(delta: float) -> void:
	if not player:return
	if not player.is_on_floor():return
	if Input.is_action_just_pressed("ui_accept"):
		if target_level_path.is_empty():return
		go_to_next_room()
		
	

func _on_body_entered(body)-> void :
	if not body is Player: return
	player = body
	


func go_to_next_room()-> void :
	#eseguiamo il metodo della classe Transition
	Transition.play_exit_transition()
	#grazie a questo comando mettimano il gioco in pausa
	get_tree().paused = true 
	#con questo comanto aspettimao finche il segnale che abbimao creato venga emesso 
	await Transition.animation_completed
	#faccimao partire l'aniamzione di entrata
	Transition.play_enter_transition()
	#togliamo il gioco dalla pausa
	get_tree().paused = false 
	#grazia questo metodo andiamoa cambiare  la scena attuale con quella che vogliamo
	get_tree().change_scene_to_file(target_level_path)

func _on_body_exited(body):
	if not body is Player: return
	player = null
