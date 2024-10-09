class_name SlideComponent
extends Node

@export_subgroup("Nodes")
@export var upper_left: RayCast2D
@export var upper_right: RayCast2D
@export var lower_left: RayCast2D
@export var lower_right: RayCast2D
var is_sliding: bool = false


func handle_slide(body: CharacterBody2D, want_to_slide: bool) ->void:
	if body.is_on_floor() and want_to_slide and body.velocity.x != 0:
		is_sliding = true
		
	else:
		check_if_stuck(body, want_to_slide)

func check_if_stuck(body: CharacterBody2D, want_to_slide: bool) -> void:
	if not want_to_slide:	
		if all_raycasts_colliding():		
			reposition_body(body)
		else:
			is_sliding = false
			
func all_raycasts_colliding() -> bool:
	if upper_left.is_colliding() and upper_right.is_colliding() or lower_left.is_colliding() and lower_right.is_colliding() :
		print("stuck")
		return true
	else:
		return false
	
func reposition_body(body: CharacterBody2D) -> void:
	body.position.x += 50


