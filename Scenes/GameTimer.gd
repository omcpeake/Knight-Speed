extends Node
class_name GameTimer

var time : float = 0.0
var sum_of_time = 0.0
var stopped : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stopped:
		return
	time += delta

func reset() -> void:
	update_sum_of_time()
	time = 0.0

func full_reset() -> void:
	time = 0.0
	sum_of_time = 0.0

func update_sum_of_time() -> void:
	sum_of_time += time

func time_to_string() -> String:
	return format_float_as_string(time)
	
func sum_of_times_as_string() -> String:
	return format_float_as_string(sum_of_time)
	
	
func format_float_as_string(floatIn :float) -> String:
	var msec = fmod(floatIn, 1) * 1000
	var sec = fmod(floatIn,60)
	var min = floatIn / 60
	#clock format
	var format_string = "%02d : %02d : %02d"
	var final_string = format_string % [min, sec, msec]
	return final_string
	
func save_time() ->void:
	#TODO implement function
	pass
	
