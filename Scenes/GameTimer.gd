extends Node
class_name GameTimer

var time : float = 0.0
var stopped : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stopped:
		return
	time += delta

func reset() -> void:
	time= 0.0

func time_to_string() -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time,60)
	var min = time / 60
	#clock format
	var format_string = "%02d : %02d : %02d"
	var final_string = format_string % [min, sec, msec]
	return final_string
