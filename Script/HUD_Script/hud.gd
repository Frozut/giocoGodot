extends CanvasLayer

@onready var gem_counter = $Gem_Counter 
@onready var hbox =$HBoxContainer
var cuore_texture = load("res://Immagini/heart.png")

func _process(delta: float) -> void:
	gem_counter.text = str(Events_and_Var.Gem)
	
		
func update_health_display()->void:
	hbox.get_node("TextureRect" + str(Events_and_Var.Healt + 1)).visible = false
		
func reset_Heart() -> void:
	for i in range(Events_and_Var.Healt):
		var cuore = TextureRect.new()
		cuore.set_name("TextureRect"+str(i+1))
		cuore.texture = cuore_texture
		hbox.add_child(cuore)

func _ready()->void:
	Events_and_Var.signal_player_hurt.connect(update_health_display)
	Events_and_Var.reset_heart.connect(reset_Heart)
	for i in range(Events_and_Var.Healt):
		var cuore = TextureRect.new()
		cuore.set_name("TextureRect"+str(i+1))
		cuore.texture = cuore_texture
		hbox.add_child(cuore)
	
