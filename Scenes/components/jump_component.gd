class_name JumpComponent
extends Node

@export_subgroup("Nodes")
@export var jump_input_buffer: Timer
@export var coyote_time: Timer

@export_subgroup("Settings")
@export var jump_velocity: float = -450.0
@export var air_jump_velocity: float = -380.0
@export var air_jump_count: int = 1

@export_subgroup("Audio")
@export var jump_audio: AudioStreamPlayer
@export var air_jump_audio: AudioStreamPlayer
@export var land_audio: AudioStreamPlayer

var current_air_jump_count: int = air_jump_count
var is_going_up: bool = false
var is_jumping: bool = false
var last_frame_on_floor: bool = false

func handle_jump(body: CharacterBody2D, want_to_jump:bool, jump_released: bool,) -> void:
	if has_just_landed(body):
		is_jumping = false
		land_audio.play()
	
	if want_to_jump and (body.is_on_floor() or not coyote_time.is_stopped()):
		#if on ground and press jump then jump
		jump(body, jump_velocity)
		
	elif want_to_jump and not body.is_on_floor() and not body.is_on_wall() and current_air_jump_count > 0:
		#if in air and have air jumps then air jump and decrement air jump
		jump(body, air_jump_velocity)
		current_air_jump_count -= 1
		
	handle_coyote_time(body)
	handle_jump_buffer(body, want_to_jump)
	handle_variable_jump_height(body, jump_released)	
	
	is_going_up = body.velocity.y < 0 and not body.is_on_floor()
	last_frame_on_floor = body.is_on_floor()
	
	#reset air jumps if on ground or wallsliding
	if body.is_on_floor() or body.is_on_wall(): current_air_jump_count = air_jump_count	

func jump(body: CharacterBody2D, velocity: float,) -> void:
	body.velocity.y = velocity
	jump_input_buffer.stop()
	is_jumping = true
	jump_audio.play()
	coyote_time.stop()
	
func has_just_landed(body: CharacterBody2D) -> bool:
	return body.is_on_floor() and not last_frame_on_floor and is_jumping

func has_just_stepped_off_ledge(body: CharacterBody2D) -> bool:
	return not body.is_on_floor() and last_frame_on_floor and not is_jumping

func handle_coyote_time(body: CharacterBody2D) ->void:
	if has_just_stepped_off_ledge(body):
		coyote_time.start()
		
	if not coyote_time.is_stopped() and not is_jumping:
		body.velocity.y = 0

func handle_variable_jump_height(body: CharacterBody2D, jump_released: bool) -> void:
	if jump_released and is_going_up:
		body.velocity.y *= 0.5

func handle_jump_buffer(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and not body.is_on_floor() and not body.is_on_wall() and current_air_jump_count == 0:
		jump_input_buffer.start()
	if body.is_on_floor() and not jump_input_buffer.is_stopped() and current_air_jump_count == 0:
		jump(body, jump_velocity)
