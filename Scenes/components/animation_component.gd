class_name AnimationComponent
extends Node

@export_subgroup("Nodes")
@export var sprite: AnimatedSprite2D

func handle_horizontal_flip(move_direction: float) -> void:
	if move_direction == 0:
		return
	sprite.flip_h =  false if move_direction > 0 else true

func handle_move_animation(move_direction: float) -> void:
	handle_horizontal_flip(move_direction)
	
	if move_direction !=0:
		sprite.play("run")
	else:
		sprite.play("idle")
		
func handle_slide_animation(is_sliding: bool) -> void:
	if is_sliding:
		sprite.play("slide")

func handle_jump_animation(is_jumping: bool, is_falling: bool, is_wall_sliding) -> void:
	if is_jumping:
		sprite.play("jump")
	elif is_wall_sliding:
		sprite.play("wall_slide")
	elif is_falling:
		sprite.play("fall")
	
func handle_death_animation():
	#death checked before calling
	sprite.play("dead")
	

