extends Area2D

@export var tube_area: Area2D


var player: Player

# Indica se il giocatore è attualmente all'interno dell'Area2D
var playerInside: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)	

func _on_body_entered(body):
	# Fai tutti i controlli del caso 
	if not body is Player or tube_area == null:
		return
	# E casta la variabile body a tipo Player 
	player = body as Player
	playerInside = true
	set_process(true) # Attiva il process durante l'input del giocatore

func _on_body_exited(body):
	# Esegui azioni quando il corpo esce dall'Area2D
	print("Il corpo ha lasciato l'Area2D.")
	playerInside = false
	set_process(false) # Disattiva il process quando il giocatore esce dall'Area2D

func _process(delta):
	# Chiamato ogni frame quando l'Area2D contiene il giocatore
	if playerInside and Input.is_action_just_pressed("ui_down"):    
		player.position = tube_area.position
		set_process(false)
