class_name GravityComponent
extends Node

@export_subgroup("Settings")
@export var gravity: float = 980.0
@export var wall_slide_gravity: float = 200.0

var is_falling: bool = false
var is_wall_sliding: bool = false

func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor():
		if body.is_on_wall() and body.velocity.y > 0:
			body.velocity.y += wall_slide_gravity * delta
		else:
			body.velocity.y += gravity * delta
	is_falling = body.velocity.y > 0 and not body.is_on_floor() and not body.is_on_wall()
	is_wall_sliding = body.velocity.y > 0 and not body.is_on_floor() and body.is_on_wall()
