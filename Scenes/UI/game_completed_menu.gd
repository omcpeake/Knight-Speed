extends CanvasLayer
class_name GameCompletedMenu

@export var gametimer_label : Label
@export var total_gametimer_label : Label
@export var default_button : Button

var NextLevelName: String

# Called when the node enters the scene tree for the first time.
func _ready():
	default_button.grab_focus()
	set_timers()

func SetNextLevelName(NewName:String) -> void:
	gametimer_label.text = GlobalGameTimer.time_to_string()
	total_gametimer_label.text = GlobalGameTimer.sum_of_times_as_string()
	NextLevelName = NewName

func set_timers() -> void:
	gametimer_label.text = GlobalGameTimer.time_to_string()
	GlobalGameTimer.update_sum_of_time()
	total_gametimer_label.text = GlobalGameTimer.sum_of_times_as_string()

func _on_return_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/menu.tscn")
	GlobalGameTimer.full_reset()
