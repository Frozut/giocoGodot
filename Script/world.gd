extends Node2D

@onready var Player: = $Player
@onready var Camera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#vaa riempire i colori vuoti con il colore che gli diciamo noi, in questo caso ci servira per lo sfondo
	RenderingServer.set_default_clear_color(Color.LIGHT_BLUE)
	#andiamo a settera la camera sul personaggio tramite codice con il metodo connect_camera
	Player.connect_camera(Camera) 
