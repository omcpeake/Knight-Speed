extends CanvasLayer
class_name LevelCompletedMenu
@export var default_button : Button

var NextLevelName: String

# Called when the node enters the scene tree for the first time.
func _ready():
	default_button.grab_focus()


func SetNextLevelName(NewName:String) -> void:
	NextLevelName = NewName


func _on_next_level_button_pressed():
	#print("pressed")
	get_tree().change_scene_to_file(NextLevelName)
