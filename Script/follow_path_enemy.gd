extends Path2D

enum ANIMATION_TYPE{
	LOOP,
	BOUNCE
}

@export var animation_type: ANIMATION_TYPE 
@onready var animation_player = $AnimationPlayer


func _ready():
	#come switch su java
	match animation_type:
		ANIMATION_TYPE.LOOP: animation_player.play("MoveEnmyAlongPathLoop")
		ANIMATION_TYPE.BOUNCE: animation_player.play("MoveEnmyAlongPathBaunch")
