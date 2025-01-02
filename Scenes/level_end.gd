extends Area2D
enum level {MENU,LEVEL1,LEVEL2,LEVEL3}

@export var level_to_load: level =  level.LEVEL1
@export var menu: PackedScene

func _on_body_entered(body):	
	if body is Player:
		var playerinst: Player = body
		playerinst.movement_enabled = false
		var instance: LevelCompletedMenu = menu.instantiate()
		set_menu_level_to_load(instance)
		get_tree().current_scene.add_child(instance)
		GlobalGameTimer.stopped = true
		#load_next_level()
	
func load_next_level() ->void:
	match level_to_load:
		level.MENU:
			get_tree().change_scene_to_file("res://Scenes/UI/menu.tscn")
		level.LEVEL1:
			get_tree().change_scene_to_file("res://Scenes/levels/level1.tscn")
		level.LEVEL2:
			get_tree().change_scene_to_file("res://Scenes/levels/level2.tscn")
		level.LEVEL3:
			get_tree().change_scene_to_file("res://Scenes/levels/level3.tscn")

func set_menu_level_to_load(menu: LevelCompletedMenu) -> void:
	match level_to_load:
		level.MENU:
			menu.SetNextLevelName("res://Scenes/menu/menu.tscn")
		level.LEVEL1:
			menu.SetNextLevelName("res://Scenes/levels/level1.tscn")
		level.LEVEL2:
			menu.SetNextLevelName("res://Scenes/levels/level2.tscn")
		level.LEVEL3:
			menu.SetNextLevelName("res://Scenes/levels/level3.tscn")


