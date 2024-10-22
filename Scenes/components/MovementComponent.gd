class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 250
@export var ground_accel_speed: float = 40
@export var ground_decel_speed: float = 20
@export var slide_accel_speed: float = 20
@export var slide_decel_speed: float = 2.5
@export var air_accel_speed: float = 20
@export var air_decel_speed: float = 3
@export var fall_accel_speed: float = 30
@export var wall_accel_speed: float = 2


func handle_horizontal_movement(body: CharacterBody2D, direction: float, is_sliding: bool, is_falling: bool) -> void:
	var velocity_change_speed: float = 0.0
	if body.is_on_floor():
		if is_sliding:
			body.velocity.x = move_toward(body.velocity.x, direction * 0, slide_decel_speed)
		else:
			velocity_change_speed = ground_accel_speed if direction!=0 else ground_decel_speed
	elif body.is_on_wall():
		velocity_change_speed = wall_accel_speed
	else:
		if is_falling:
			velocity_change_speed = fall_accel_speed if direction!=0 else air_decel_speed
		else:
			velocity_change_speed = air_accel_speed if direction!=0 else air_decel_speed
		
	body.velocity.x = move_toward(body.velocity.x, direction * speed, velocity_change_speed)

func stop_movement(body: CharacterBody2D) -> void :
	body.velocity = Vector2(0,0)
