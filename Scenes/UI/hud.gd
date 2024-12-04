extends Control
class_name HUD

@export var gametimer_label : Label

var gametimer : GameTimer

func _ready():
	gametimer = get_tree().get_first_node_in_group("gametimer")


func _process(delta):
	update_gametimer_label()

func update_gametimer_label():
	gametimer_label.text = gametimer.time_to_string()
