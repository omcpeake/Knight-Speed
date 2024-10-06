class_name GravityComponent
extends Node

@export_subgroup("Settings")
@export var gravity: float = 980.0
@export var wall_slide_gravity: float = 100

var is_falling: bool = false
var is_wall_sliding: bool = false

func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	is_wall_sliding = body.is_on_wall() and not body.is_on_floor()
	is_falling = body.velocity.y > 0 and not body.is_on_floor() and not is_wall_sliding

	
	
	if not body.is_on_floor():
		if is_wall_sliding and body.velocity.y > 0:
			#reduce gravity when wall sliding
			body.velocity.y += wall_slide_gravity * delta
			if body.velocity.y >= 100:
					body.velocity.y = 100	
		else:
			if is_falling:
				#increase gravity on descent
				body.velocity.y += gravity * 1.5 * delta
				#clamp fall speed
				if body.velocity.y >= 500:
					body.velocity.y = 500	
			else:
				body.velocity.y += gravity * delta
