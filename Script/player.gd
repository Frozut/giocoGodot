extends CharacterBody2D
#class_name serve per far si che le altre classi vedano quasta classe con il nome asseggnato, in questo caso Player --> per piccolo esempio guarda spike
class_name Player
#creazione delle variabili che sono presenti nello Script Variables
#(ovevro che le vedi cliccando il nodo player a destra, puoi modificarle senza toccare il codice)
@export var JUMP_FORCE :int= -160
@export var JUMP_RELESASED_FORCE:int= -60
@export var MAX_SPEED :int= 75
@export var ACCELARATION :int= 600
@export var FRICTION:int= 600
@export var skin:String
@export var DOUBLE_JUMP:int =1
#creazione delle costanti
const GRAVITY:int = 500
const ADITION_FALL_GRAVITY:int = 120
#creazione delle variabili
@onready var PLAYER_SPRITE =  $AnimatedSprite2D
@onready var LADDER_CHECK = $Ladder_Check
@onready var JUMP_BUFFER_TIMER = $Jump_Buffer
@onready var COYOTE_JUMP_TIMER = $Coyote_jump_timer
@onready var REMOTE_TRANBSFORM = $RemoteTransform2D
@onready var TIMER_INVULERABILITY = $TimerInvulnerability
#creazione di un enum per gli stati questa e` la verisione semplice
enum {MOVE,CLIMB}
var state = MOVE
var buffered_jump:bool = false
var double_jump_comodo 
var coyote_jump:bool = false
var max_healt:int


func _ready() -> void:
	max_healt= 	Events_and_Var.Healt
	double_jump_comodo = DOUBLE_JUMP
	#funzione che permetti di cambiare la skin
	PLAYER_SPRITE.frames = load(skin)

func _physics_process(delta)-> void:
	# prende un valore compreso tar 1 e -1 per identificare la direzione che i personaggio dovre prendere
	var input :=Vector2.ZERO 
	input.x = Input.get_axis("ui_left","ui_right")
	input.y = Input.get_axis("ui_up","ui_down")
	#questo e come se fosse uno switch in java 
	match state:
		MOVE: move_state(input,delta)
		CLIMB:climb_state(input)


func move_state(input,delta)->void:
	#se stiamo collidendo con una ladder e abbiamo il tasto per saltare  attivo cambiamo lo status a CLIMB 
	if is_on_ladder() and Input.is_action_just_pressed("ui_up"):
		state =CLIMB
	#applica la garvita` al personaggio
	apply_gvavity(delta)
	# richiama i metodi per applicare il movimento
	if input.x == 0:
		PLAYER_SPRITE.play("Idle")
		applay_friction(delta)
	else :
		if input.x ==-1:
			PLAYER_SPRITE.flip_h= false 
		else:
			PLAYER_SPRITE.flip_h= true
		PLAYER_SPRITE.play("Run")
		applay_acceleration(input.x,delta)
		
	if is_on_floor():
		#serve per poter resettare il doppio salto quando tocchiamo terra
		reset_extra_jump()
	#serve perr saltare
	if can_jump():
		input_jump()
	else: # questo serve per avere un salto variabile che ti faccia saltare minimo ubn blocco
		PLAYER_SPRITE.play("Jump")
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELESASED_FORCE:
			#permette di saltare 
			velocity.y=  JUMP_RELESASED_FORCE
		if Input.is_action_just_pressed("ui_up") and DOUBLE_JUMP > 0:
			SoundPlayer.play_sound(SoundPlayer.JUMP)
			#serve per  fare il doppio salto 
			velocity.y= JUMP_FORCE
			DOUBLE_JUMP -= 1
		#questo controllo serve per attivare un timer nel quale il personaggio non puo piu fare il dopuble jump
		if 	Input.is_action_just_pressed("ui_up") :
			buffered_jump = true
			JUMP_BUFFER_TIMER.start()
		if velocity.y >0:
			velocity.y += ADITION_FALL_GRAVITY*delta
	var was_in_air = not is_on_floor()
	var was_on_floor = is_on_floor()
	#metodo he serve per applicare la velocita` al personaggio
	move_and_slide()
	var just_landed= is_on_floor() and was_in_air
	if(just_landed):
		PLAYER_SPRITE.play("Run")
		PLAYER_SPRITE.frame = 1 
	#se non è sul terrono, ma lo era in precedenza allora significha che ha appena lasciato il terro no
	var just_left_ground = not is_on_floor() and was_on_floor
	if just_left_ground and velocity.y>=0:
		coyote_jump = true
		COYOTE_JUMP_TIMER.start()
	

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

func can_jump() -> bool:
	return is_on_floor() or coyote_jump
	
func reset_extra_jump() -> void:
	DOUBLE_JUMP = double_jump_comodo
func input_jump():
	if Input.is_action_just_pressed("ui_up") or buffered_jump:
		SoundPlayer.play_sound(SoundPlayer.JUMP)
		velocity.y= JUMP_FORCE
		buffered_jump = false

func is_on_ladder() ->bool:
	#se non sta collidendo con niente ritorna falso
	if  not LADDER_CHECK.is_colliding(): return false
	#creiamo una variabile che ci permette di capire grazia al metodo get_collider() che tip di collider e` 
	var collider = LADDER_CHECK.get_collider()
	#faccianmo un controllo se il collider non e` LAdder alora ritorniamo false
	if not collider is Ladder :return false
	#se tutte i controlli di prima erano falsi allora vuol dire che siamo su una ladder e di consegnuenza ritorniamo true
	return true
	
#metodo che permete di apllicare la garita`
func apply_gvavity(delta)->void:
	velocity.y += GRAVITY*delta
	velocity.y = min(velocity.y,300)
#metodo che permete di apllicare la frizione quando si ferma il personaggio
func applay_friction(delta)->void:
		#move toword far si che mi sposti da una posizione iniziale  ad una finale col tempo che decide il programmatore
	velocity.x = move_toward(velocity.x,0, FRICTION *delta)
	
func applay_acceleration(amount,delta)->void:
		#move toword far si che mi sposti da una posizione iniziale  ad una finale col tempo che decide il programmatore
	velocity.x = move_toward(velocity.x,MAX_SPEED * amount, ACCELARATION*delta)

#questo metodo si attiva quando il timer che abboiamo impostato arriova a zero
#per crearlo dobbiamo andare sul timer -->nodo --> selezionare il metodo timeout
func _on_jump_buffer_timeout()->void:
	buffered_jump=false
	
func player_taking_damage()-> void :
	if TIMER_INVULERABILITY.is_stopped():TIMER_INVULERABILITY.start()
	#il sound Playuer lo possiamop chiamare quando vogliamo sicome lo abbiamo messo nelle risorse del progetto
	#andare a vedere in Progetto --> impostazione del progetto--> autoload, cosi facendo il sopund che abbiamo messenno verra
	#runnato separatamente dal mondo quindi non ci sono problemi che venga eliminato
	SoundPlayer.play_sound(SoundPlayer.HURT)
	Events_and_Var.Healt -=1
	set_modulate(Color(1,0.3,0.3,0.3))
	if velocity.x >0:
		velocity.x = -200	
	else: 
		velocity.x = 200	
	velocity.y = -80
	#mi permette ti chiamare il segnale che e` stato conensso nella clasws hud per togliere 1 cuore
	Events_and_Var.emit_signal("signal_player_hurt")
	if  Events_and_Var.Healt==0:player_die()
	
	
	
func player_die()->void:
	Events_and_Var.Healt = max_healt
	#serve per resettare la scena come è all'inizio
	queue_free()
	#get_tree().reload_current_scene()
	Events_and_Var.emit_signal("player_died")
	
	
func _on_coyote_jump_timer_timeout()->void:
	coyote_jump = false

func connect_camera(camera)->void:
	var camera_path = camera.get_path()
	REMOTE_TRANBSFORM.remote_path = camera_path

func jump_on_bonch_enemy()->void:
	velocity.y = -80
	

func _on_timer_invulnerability_timeout() -> void:
	set_modulate(Color.WHITE)
