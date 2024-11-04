extends Area2D
enum level {MENU,LEVEL1,LEVEL2,LEVEL3}

@export var level_to_load: level =  level.LEVEL1
	

func _on_body_entered(body):
	if body is Player:
		load_next_level()
	
func load_next_level() ->void:
	match level_to_load:
		level.MENU:
			get_tree().change_scene_to_file("res://Scenes/menu/menu.tscn")
		level.LEVEL1:
			get_tree().change_scene_to_file("res://Scenes/levels/level1.tscn")
		level.LEVEL2:
			get_tree().change_scene_to_file("res://Scenes/levels/level2.tscn")
		level.LEVEL3:
			get_tree().change_scene_to_file("res://Scenes/levels/level3.tscn")
