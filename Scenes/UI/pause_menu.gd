extends CanvasLayer
class_name PauseMenu


func unpause():
	## unpauses the game and deletes the menu
	get_tree().paused = false
	queue_free()
	
func _on_resume_button_pressed():
		unpause()


func _on_respawn_button_pressed():
	var player = get_tree().get_first_node_in_group("Player")
	if player is Player:
		unpause()
		player.health_component.kill()


func _on_quit_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/menu.tscn")
