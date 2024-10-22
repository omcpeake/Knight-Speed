class_name KillzoneComponent
extends Node


func kill_unit(body: CharacterBody2D):
	if body is Player:
		#TODO extend to all unit classes should more units be added
		print ("player detected")
		var  player_ref: Player = body
		player_ref.health_component.kill()
		

func damage_unit(body: CharacterBody2D, damage_amount: float):
	if body is Player:
		#TODO extend to all unit classes should more units be added
		print ("player detected")
		var  player_ref: Player = body
		player_ref.health_component.take_damage(damage_amount)
