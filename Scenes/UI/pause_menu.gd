extends CanvasLayer
class_name PauseMenu


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func unpause():
	get_tree().paused = false
	queue_free()
	
func _on_resume_button_pressed():
		unpause()


func _on_respawn_button_pressed():
	var player = get_tree().get_first_node_in_group("Player")
	if player is Player:
		unpause()
		player.health_component.kill()


func _on_restart_level_button_pressed():
	pass # Replace with function body.


func _on_quit_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/menu.tscn")
