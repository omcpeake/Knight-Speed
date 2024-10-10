extends Area2D



func _on_body_entered(body):
	if body is Player:
		#TODO extend to all unit classes should more units be added
		print ("player detected")
		var  player_ref: Player = body
		player_ref.health_component.take_damage(5)
		
