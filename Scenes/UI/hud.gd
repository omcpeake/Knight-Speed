extends Control
class_name HUD

@export var gametimer_label : Label

#using global variable instead
#var gametimer : GameTimer

func _ready():
	#gametimer = get_tree().get_first_node_in_group("gametimer")
	pass


func _process(delta):
	update_gametimer_label()

func update_gametimer_label():
	gametimer_label.text = GlobalGameTimer.time_to_string()
