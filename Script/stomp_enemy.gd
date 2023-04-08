extends Node2D

#creo un enum per fare una seplice state machine(molto importante guardare un video a riguardo)
enum {HOVER, FALL,LAND, RISE}

var state = HOVER
#prendo la posisizone iniziale del nemico e la metto all'interno di una variabile 
@onready var start_position = global_position
@onready var timer = $Timer
@onready var rayCast =$RayCast2D
@onready var animationPLayer = $AnimatedSprite2D
@onready var particles = $GPUParticles2D
func _physics_process(delta):
	#come swotch in java
	match state:
		HOVER:hover_State()
		FALL:fall_State(delta)
		LAND:land_State()
		RISE:rise_State(delta)
 

func hover_State():
	state = FALL

func fall_State(delta):
	animationPLayer.play("Fall")
	#lo facciamo muovere verso il basso,  usiamo position al posto che velocity siccome e` un semplice nodo e non e`un character 2d 
	position.y +=100*delta
	#controlliamo se il raycast stia collidendo
	if rayCast.is_colliding():
		var collision_point= rayCast.get_collision_point()
		position.y = collision_point.y
		state = LAND 
		#facciamo partitre il timer quando rycast sta collidendo con il terreno 
		timer.start(1.00)
		#attiviamo lo sray di particelle
		particles.emitting =true

func land_State():
	if timer.time_left ==0:
		state = RISE
	
	
func rise_State(delta):
	animationPLayer.play("Rise")
	#move toword far si che mi sposti da una posizione iniziale  ad una finale col tempo che decide il programmatore
	position.y = move_toward(position.y,start_position.y, 20 * delta)
	if position.y == start_position.y:
		state = HOVER
