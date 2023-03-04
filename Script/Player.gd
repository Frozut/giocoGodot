extends KinematicBody2D


#creazione delle variabili che sono presenti nello Script Variables
#(ovevro che le vedi cliccando il nodo player a destra, puoi modificarle senza toccare il codice)
export (int)var JUMP_FORCE = -160
export (int) var JUMP_RELESASED_FORCE = -40
export (int) var MAX_SPEED = 75
export (int) var ACCELARATION = 10
export (int) var FRICTION = 10
export (String) var skin
#creazione delle costanti
const GRAVITY = 5
const ADITION_FALL_GRAVITY = 2

#creazione delle variabili
var velocity = Vector2.ZERO
onready var PLAYER_SPRITE =  $AnimatedSprite

func _ready():
	#funzione che permetti di cambiare la skin
	PLAYER_SPRITE.frames = load(skin)

func _physics_process(delta):
	#applica la garvita al personaggio
	apply_gvavity()
	# prende un valore compreso tar 1 e -1 per identificare la direzione che i personaggio dovre prendere
	var input =Vector2.ZERO 
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	# richiama i metodi per applicare il movimento
	if input.x == 0:
		PLAYER_SPRITE.play("Idle")
		applay_friction()
	else :
		if input.x ==-1:
			PLAYER_SPRITE.flip_h= false 
		else:
			PLAYER_SPRITE.flip_h= true
		PLAYER_SPRITE.play("Run")
		applay_acceleration(input.x)
	
	#serve epr saltare
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y= JUMP_FORCE
	else: # questo serve per avere un salto variabile che ti faccia saltare minimo ubn blocco
		PLAYER_SPRITE.play("Jump")
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELESASED_FORCE:
			velocity.y=  JUMP_RELESASED_FORCE
		if velocity.y >0:
			velocity.y += ADITION_FALL_GRAVITY
			
			
	var was_in_air = not is_on_floor()
	#metodo he serve per applicare la velocita` al personaggio
	velocity = move_and_slide(velocity,Vector2.UP)
	var just_landed= is_on_floor() and was_in_air
	if(just_landed):
		PLAYER_SPRITE.play("Jump")
		PLAYER_SPRITE.frame = 1
	
	
	
	
	
func apply_gvavity():
	velocity.y += GRAVITY
	
func applay_friction():
	velocity.x = move_toward(velocity.x,0, FRICTION	)
	
func applay_acceleration(amount):
	velocity.x = move_toward(velocity.x,MAX_SPEED * amount, ACCELARATION)
