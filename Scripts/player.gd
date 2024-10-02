extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: JumpComponent
@export var wall_jump_component: WallJumpComponent


func _physics_process(delta):	
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	animation_component.handle_move_animation(input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input())
	wall_jump_component.handle_wall_jump(self, input_component.input_horizontal, gravity_component.is_wall_sliding, input_component.get_jump_input())
	animation_component.handle_jump_animation(jump_component.is_jumping, gravity_component.is_falling, gravity_component.is_wall_sliding)
		
	
	move_and_slide()
