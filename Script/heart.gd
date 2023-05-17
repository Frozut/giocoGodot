extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if not body is Player: return
	if Events_and_Var.Healt == 3 : return
	Events_and_Var.Healt +=1;
	print(Events_and_Var.Healt)
	Events_and_Var.emit_signal("take_heart")
	queue_free()
