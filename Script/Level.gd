extends Node2D

const  playerScene = preload("res://Player and Enemy/player.tscn")

var player_spaw_location = Vector2.ZERO	
@onready var player: = $Player
@onready var Camera = $Camera2D
@onready var timer = $Timer
@onready var music =$AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()
	#va a riempire i colori vuoti con il colore che gli diciamo noi, in questo caso ci servira per lo sfondo
	RenderingServer.set_default_clear_color(Color.LIGHT_BLUE)
	#andiamo a settera la camera sul personaggio tramite codice con il metodo connect_camera
	player.connect_camera(Camera) 
	#grazie alla funzione sottostante riusciamo a prendere la posiizone del palyer quando spowna per successivamente settarla quando creamoun nuovo player
	player_spaw_location = player.global_position
	#questo serve per collegare l'evento che abbiamo creato nella script Events() che adesso e` una variabile globale 
	#guarda Sound player per capire come si fa, ATTENZIONE E` DIVERSO RISPETO Alla precedente versione di godot
	Events_and_Var.player_died.connect(_on_player_died) 
	Events_and_Var.hit_checkpoint.connect(_on_hit_checkpoint)


#questa funzione si collega con quella l'events che ce` sopra
func _on_player_died():
	#impostiamo il timer a 1 secondo 
	timer.start(1.0)
	#prima di fare quello che segue la riga sottostante aspettimao che il timer finisca grazie alla funzioe await
	await timer.timeout
	#creaiamo il player nuovo  con questa riga di codice 
	var player = playerScene.instantiate()
	#settimano la posizion del player che abbiamo preso sopra quando abbiamo creato il mondo con Player.global_position
	player.global_position= player_spaw_location
	#successivamente lo aggiungiamo alla mappa
	add_child(player)
	#ed infine lo collegghiamo alla camera
	player.connect_camera(Camera)
	#mi permette ti chiamare il segnale che e` stato conensso nella clasws hud per rimettere i cuori
	Events_and_Var.emit_signal("reset_heart")

func _on_hit_checkpoint(checkpoint_position):
	player_spaw_location = checkpoint_position
	

	
