extends Node

const save_path:String ="res://savegame.bin"



func save_game()-> void :
	var file = FileAccess.open(save_path,FileAccess.WRITE) 
	#creiamo un dizionario docve mettere le cose che ci serve
	var data: Dictionary ={
		"playerGem": Events_and_Var.Gem,
	}
	#mette il dizionare dentro un json
	var jstr= JSON.stringify(data)
	#srive il json sul file 
	file.store_line(jstr)
	
func load_game()->void:
	#accesso al file per poterlo legegrlo
	var file = FileAccess.open(save_path,FileAccess.READ) 
	#controlliamo se il path esista e di conseguenza anche se il file esista
	if FileAccess.file_exists(save_path)==true:
		#controlliamo se ha raggiunto la fin il file
		if not file.eof_reached():
			#transformiamo la riga json in una variabile 
			var current_line= JSON.parse_string(file.get_line())
			if current_line:
				#assegnamo la variabiele a quello che ci interessa
				Events_and_Var.Gem = current_line["playerGem"]
	file.close()
