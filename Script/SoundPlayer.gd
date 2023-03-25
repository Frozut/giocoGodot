extends Node2D

const HURT = preload("res://Sounds/hurt.wav")
const JUMP = preload("res://Sounds/Jump.wav") 

@onready var audioPlayer= $Audio_Players

func play_sound(sound):
	for audioStreamPlayer in audioPlayer.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break
		
