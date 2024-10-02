class_name JumpComponent
extends Node

@export_subgroup("Settings")
@export var jump_velocity: float = -350.0
@export var air_jump_velocity: float = -250.0
@export var air_jump_count: int = 1
#var is_jumping: bool = false

var is_going_up: bool = false

func handle_jump(body: CharacterBody2D, want_to_jump:bool, jump_released: bool) -> void:
	if want_to_jump and body.is_on_floor():
		jump(body, jump_velocity)
		
	elif want_to_jump and not body.is_on_floor() and not body.is_on_wall() and air_jump_count > 0:
		jump(body, air_jump_velocity)
		air_jump_count -= 1
		
	is_going_up = body.velocity.y < 0 and not body.is_on_floor()
	if body.is_on_floor(): air_jump_count = 1
	handle_variable_jump_height(body, jump_released)

func jump(body: CharacterBody2D, velocity: float) -> void:
	body.velocity.y = velocity
	
func handle_variable_jump_height(body: CharacterBody2D, jump_released: bool) -> void:
	if jump_released and is_going_up:
		body.velocity.y = 0
