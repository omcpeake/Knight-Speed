class_name GravityComponent
extends Node

@export_subgroup("Settings")
@export var gravity: float = 980.0
@export var wall_slide_gravity: float = 100

@export_subgroup("Audio")
@export var wall_attach_audio: AudioStreamPlayer
@export var wall_slide_audio: AudioStreamPlayer

var is_falling: bool = false
var is_wall_sliding: bool = false
var last_frame_on_wall: bool = false

func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	if has_just_wall_slid(body):
		wall_attach_audio.play()

	is_falling = body.velocity.y > 0 and not body.is_on_floor()
	is_wall_sliding = body.is_on_wall() and not body.is_on_floor()
	
	
	
	
	if not body.is_on_floor():
		if is_wall_sliding and body.velocity.y > 0:
			#reduce gravity when wall sliding
			body.velocity.y += wall_slide_gravity * delta
			if body.velocity.y >= 100:
					body.velocity.y = 100
			if wall_slide_audio.playing == false:
				wall_slide_audio.pitch_scale = randf_range(0.9,1.1)
				wall_slide_audio.play()		
			
		else:	
			wall_slide_audio.stop()		
			if is_falling:
				#increase gravity on descent
				body.velocity.y += gravity * 1.5 * delta
				#clamp fall speed
				if body.velocity.y >= 500:
					body.velocity.y = 500	
			else:
				body.velocity.y += gravity * delta
			
	else:
		wall_slide_audio.stop()		
	last_frame_on_wall = body.is_on_wall()


func has_just_wall_slid(body: CharacterBody2D) -> bool:
	return body.is_on_wall() and not last_frame_on_wall
