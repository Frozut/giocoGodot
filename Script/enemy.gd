extends CharacterBody2D

var direction := Vector2.RIGHT

@onready var enemy_Sprite = $AnimatedSprite2D

@onready var leftLedgeCheck = $leftLedgeCheck
@onready var rightLedgeCheck = $rightLedgeCheck

func _physics_process(delta):
	enemy_Sprite.play("Walking")
	#metodo che mi permette di capire se mi sto scontrasndo contro un muro
	var found_wall :bool= is_on_wall()
	#capisco se sta facedo collissione col terreno nel caso si vuol dire che non si trova su un orlo
	#in caso contrario vuol dire che sotto c'e il vuoto 
	var found_edge = not leftLedgeCheck.is_colliding() or not rightLedgeCheck.is_colliding()
	if found_wall or found_edge:
		direction *= -1
		if enemy_Sprite.flip_h==false:
			enemy_Sprite.flip_h=true
		else:
			enemy_Sprite.flip_h=false
	velocity = direction*25
	move_and_slide()
