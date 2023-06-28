extends Area2D


@onready var text_label: Label = $Control/Label

@export var text:String
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if not body is Player: return
	text_label.text = text
	text_label.visible = true


func _on_body_exited(body: Node2D) -> void:
	text_label.visible = false
