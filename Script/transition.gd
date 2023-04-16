extends CanvasLayer 

@onready var animation_player = $AnimationPlayer

signal animation_completed

func play_exit_transition():
	animation_player.play("Exit_Level")


func play_enter_transition():
	animation_player.play("Entry_Level")

#funzione collegabile dell' Anietion player 
func _on_animation_player_animation_finished(anim_name):
	emit_signal("animation_completed")
