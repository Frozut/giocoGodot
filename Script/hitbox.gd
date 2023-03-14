extends Area2D

#abbiamo creato questa classe hitbox per potere rendere universale il collision shape dei nemici
#grazie a cio noi possiamo andare sui nodi che ci interessano abbiano una hitbox contro il nostro player e cliccare collega
#o ctrl shift a 
#per andare a creare il metodo dobbiamo andare su nodi dell'area2d e selezionare body_entered 
#che tradotto significa letteralmente in collisione con un body
func _on_body_entered(body):
	if body is Player:
		
		#serve per resettare la scena come è all'inizio
		get_tree().reload_current_scene()
		
