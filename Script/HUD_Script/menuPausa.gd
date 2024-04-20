extends CanvasLayer


func _input(event)->void :
	if event.is_action_pressed("escape") and get_tree().current_scene.name != "menuProva" :
		set_visible(!get_tree().paused) # if not pause then hide
		get_tree().paused = !get_tree().paused # toggle pause status
	


func _on_exit_button_pressed()-> void :
	get_tree().quit()


func _on_resume_button_pressed() -> void:
	set_visible(false)
	get_tree().paused = false
