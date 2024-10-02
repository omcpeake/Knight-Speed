class_name JumpComponent
extends Node

@export_subgroup("Nodes")
@export var jump_input_buffer: Timer

@export_subgroup("Settings")
@export var jump_velocity: float = -350.0
@export var air_jump_velocity: float = -300.0
@export var air_jump_count: int = 1
var current_air_jump_count: int = air_jump_count
var is_going_up: bool = false

func handle_jump(body: CharacterBody2D, want_to_jump:bool, jump_released: bool) -> void:
	if want_to_jump and body.is_on_floor():
		#if on ground and press jump then jump
		jump(body, jump_velocity)
		
	elif want_to_jump and not body.is_on_floor() and not body.is_on_wall() and current_air_jump_count > 0:
		#if in air and have air jumps then air jump and decrement air jump
		jump(body, air_jump_velocity)
		current_air_jump_count -= 1
		
	handle_jump_buffer(body, want_to_jump)
	handle_variable_jump_height(body, jump_released)	
	
	is_going_up = body.velocity.y < 0 and not body.is_on_floor()
	#reset air jumps if on ground or wallsliding
	if body.is_on_floor() or body.is_on_wall(): current_air_jump_count = air_jump_count	

func jump(body: CharacterBody2D, velocity: float) -> void:
	body.velocity.y = velocity
	jump_input_buffer.stop()

func handle_variable_jump_height(body: CharacterBody2D, jump_released: bool) -> void:
	if jump_released and is_going_up:
		body.velocity.y = -50

func handle_jump_buffer(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and not body.is_on_floor() and not body.is_on_wall() and current_air_jump_count == 0:
		jump_input_buffer.start()
		print("buffer started")
		if body.is_on_floor() and not jump_input_buffer.is_stopped() and current_air_jump_count ==0:
			jump(body, jump_velocity)
			print("jump buffered")
