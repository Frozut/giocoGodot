extends CanvasLayer

@onready var gem_counter = $Gem_Counter 

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gem_counter.text = str(Events_and_Var.Gem)
