extends Node
class_name AmbientNoisePlayer

@export_subgroup("Nodes")
@export var constant_sound: AudioStreamPlayer
@export var random_sound: AudioStreamPlayer
@export var random_sound_range_min: float = 5
@export var random_sound_range_max: float = 30
@export var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = randf_range(random_sound_range_min,random_sound_range_max)
	timer.start()
	
	constant_sound.play()


func _on_timer_timeout():
	random_sound.pitch_scale = randf_range(0.9,1.1)
	random_sound.play()
	timer.wait_time = randf_range(random_sound_range_min,random_sound_range_max)
	timer.start()
