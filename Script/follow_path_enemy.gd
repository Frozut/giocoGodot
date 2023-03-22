#tool permette di mettere 
@tool
extends Path2D

enum ANIMATION_TYPE{
	LOOP,
	BOUNCE
}
#per mettere i det personalizzati dopo la variabile mettere : set = "nome del metodo "-->per i get la stessa cosa ma con get
@export var animation_type : ANIMATION_TYPE: set = set_animation_type
@export var speed : int = 1 : set = set_speed

@onready var animation_player = $AnimationPlayer

func set_animation_type(value):
	animation_type = value
	var ap = find_child("AnimationPlayer")
	if ap:play_update_animation(ap)

func _ready():
	play_update_animation(animation_player)

func set_speed(value):
	speed = value 
	#serve per ricavare AnimationPlayer e i sui vari parametri
	var ap = find_child("AnimationPlayer")
	# speed scale modifica la velocità in cui l'animazione vienen eseguita
	if ap: ap.speed_scale = speed
	

func play_update_animation(ap):
	#come switch su java
	match animation_type:
		ANIMATION_TYPE.LOOP:ap.play("MoveEnmyAlongPathLoop")
		ANIMATION_TYPE.BOUNCE:ap.play("MoveEnmyAlongPathBaunch")
