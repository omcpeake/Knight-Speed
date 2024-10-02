class_name WallJumpComponent
extends Node

@export_subgroup("Settings")
@export var wall_jump_vertical_velocity: float = -350.0
@export var wall_jump_horizontal_velocity: float = 300




func handle_wall_jump(body: CharacterBody2D, direction: float, is_wall_sliding: bool, want_to_jump: bool) -> void:
	if want_to_jump and is_wall_sliding:
		body.velocity.y = wall_jump_vertical_velocity
		body.velocity.x = wall_jump_horizontal_velocity * (direction * -1)

