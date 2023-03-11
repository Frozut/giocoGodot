extends CharacterBody2D
#class_name serve per far si che le altre classi vedano quasta classe con il nome asseggnato, in questo caso Player --> per piccolo esempio guarda spike
class_name Player
#creazione delle variabili che sono presenti nello Script Variables
#(ovevro che le vedi cliccando il nodo player a destra, puoi modificarle senza toccare il codice)
@export var JUMP_FORCE :int= -160
@export var JUMP_RELESASED_FORCE:int= -60
@export var MAX_SPEED :int= 75
@export var ACCELARATION :int= 10
@export var FRICTION:int= 10
@export var skin:String
#creazione delle costanti
const GRAVITY = 5
const ADITION_FALL_GRAVITY = 2

#creazione delle variabili
@onready var PLAYER_SPRITE =  $AnimatedSprite2D
@onready var LADDER_CHECK = $Ladder_Check
#creazione di un enum per gli stati questa e` la verisione semplice
enum {MOVE,CLIMB}
var state = MOVE

func _ready():
	#funzione che permetti di cambiare la skin
	PLAYER_SPRITE.frames = load(skin)

func _physics_process(delta):
	# prende un valore compreso tar 1 e -1 per identificare la direzione che i personaggio dovre prendere
	var input =Vector2.ZERO 
	input.x = Input.get_axis("ui_left","ui_right")
	input.y = Input.get_axis("ui_up","ui_down")
	#questo e come se fosse uno switch in java 
	match state:
		MOVE: move_state(input)
		CLIMB:climb_state(input)
		

	
	

func move_state(input):
	#se stiamo collidendo con una ladder e abbiamo il tasto per saltare  attivo cambiamo lo status a CLIMB 
	if is_on_ladder() and Input.is_action_pressed("ui_up"):
		state =CLIMB
	#applica la garvita` al personaggio
	apply_gvavity()
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
	move_and_slide()
	var just_landed= is_on_floor() and was_in_air
	if(just_landed):
		PLAYER_SPRITE.play("Run")
		PLAYER_SPRITE.frame = 1 
	
	
func climb_state(input):
	if input.y == 0:
		PLAYER_SPRITE.play("Idle")
	else :
		if input.x ==-1:
			PLAYER_SPRITE.flip_h= false 
		else:
			PLAYER_SPRITE.flip_h= true
		PLAYER_SPRITE.play("Run")
	
	
	if is_on_ladder() and not Input.is_action_pressed("ui_up"):
		state = MOVE
	if not is_on_ladder():
		state = MOVE
	velocity = input * 50
	move_and_slide()

	



func is_on_ladder():
	#se non sta collidendo con niente ritorna falso
	if  not LADDER_CHECK.is_colliding(): return false
	#creiamo una variabile che ci permette di capire grazia al metodo get_collider() che tip di collider e` 
	var collider = LADDER_CHECK.get_collider()
	#faccianmo un controllo se il collider non e` LAdder alora ritorniamo false
	if not collider is Ladder :return false
	#se tutte i controlli di prima erano falsi allora vuol dire che siamo su una ladder e di consegnuenza ritorniamo true
	return true

	
func apply_gvavity():
	velocity.y += GRAVITY
	velocity.y = min(velocity.y,300)
	
func applay_friction():
	velocity.x = move_toward(velocity.x,0, FRICTION	)
	
func applay_acceleration(amount):
	velocity.x = move_toward(velocity.x,MAX_SPEED * amount, ACCELARATION)
