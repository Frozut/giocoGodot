extends CanvasLayer


func _input(event)->void :
	if event.is_action_pressed("escape"):
		set_visible(!get_tree().paused) # if not pause then hide
		get_tree().paused = !get_tree().paused # toggle pause status
	
