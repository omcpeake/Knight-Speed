class_name Menu
extends Control
@export var default_button : Button

# Called when the node enters the scene tree for the first time.
func _ready():
	default_button.grab_focus()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels/level1.tscn")


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
