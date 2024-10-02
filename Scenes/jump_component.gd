class_name JumpComponent
extends Node

@export_subgroup("Settings")
@export var jump_velocity: float = -350.0
@export var air_jump_count: int = 1
var is_jumping: bool = false

func handle_jump(body: CharacterBody2D, want_to_jump:bool) -> void:
	if want_to_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
	elif want_to_jump and not body.is_on_floor() and not body.is_on_wall() and air_jump_count > 0:
		body.velocity.y = jump_velocity/1.5
		air_jump_count -= 1
		
	is_jumping = body.velocity.y < 0 and not body.is_on_floor()
	if body.is_on_floor(): air_jump_count = 1
