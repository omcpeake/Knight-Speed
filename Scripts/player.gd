extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: JumpComponent
@export var wall_jump_component: WallJumpComponent
@export var slide_component: SlideComponent
@export var health_component: HealthComponent

@onready var standing_collision = $StandingCollision
@onready var crouching_collision = $CrouchingCollision


func _physics_process(delta):	
	gravity_component.handle_gravity(self, delta)
	#ground
	slide_component.handle_slide(self, input_component.get_slide_input())
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal, slide_component.is_sliding)
	update_capsule_collision()
	#ground animations
	animation_component.handle_move_animation(input_component.input_horizontal)
	animation_component.handle_slide_animation(slide_component.is_sliding)

	#air
	jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())
	wall_jump_component.handle_wall_jump(self, input_component.input_horizontal, gravity_component.is_wall_sliding, input_component.get_jump_input())
	animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling, gravity_component.is_wall_sliding)
	
	move_and_slide()

func update_capsule_collision() -> void:
	if slide_component.is_sliding:
		standing_collision.disabled = true
		crouching_collision.disabled = false
	else:
		standing_collision.disabled = false
		crouching_collision.disabled = true
		
