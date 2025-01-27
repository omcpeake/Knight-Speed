class_name Player
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

@export var menu :PackedScene

@export var pixelation: ColorRect
var pixel_size: float = 0.001
var pixel_size_delta = 0.08
var pixelation_completed:bool = true
var flip:int = 1

@export_subgroup("Audio")
@export var jump_audio: AudioStreamPlayer
@export var air_jump_audio: AudioStreamPlayer
@export var wall_jump_audio: AudioStreamPlayer
@export var land_audio: AudioStreamPlayer
@export var walk_audio: AudioStreamPlayer
@export var wall_slide_audio: AudioStreamPlayer
@export var slide_audio: AudioStreamPlayer
@export var footstep_audio: AudioStreamPlayer

var footstep_anim_frames: Array = [1,6]

@onready var standing_collision = $StandingCollision
@onready var crouching_collision = $CrouchingCollision

var spawn_point : Vector2
var movement_enabled : bool = true



func _ready():
	GlobalGameTimer.reset()
	GlobalGameTimer.stopped = false

func _physics_process(delta):
	if input_component.get_pause_input():
			toggle_pause_game()
	gravity_component.handle_gravity(self, delta)
	if(movement_enabled):
		
		#ground
		slide_component.handle_slide(self, input_component.get_slide_input())
		movement_component.handle_horizontal_movement(self, input_component.input_horizontal, slide_component.is_sliding, gravity_component.is_falling)
		update_capsule_collision()
		#ground animations
		animation_component.handle_move_animation(input_component.input_horizontal)
		animation_component.handle_slide_animation(slide_component.is_sliding)

		#air
		jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())
		wall_jump_component.handle_wall_jump(self, input_component.input_horizontal, gravity_component.is_wall_sliding, input_component.get_jump_input())
		animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling, gravity_component.is_wall_sliding)
		pixelate(delta)
		check_if_alive()
	
	
	if health_component.is_dead:
		respawn(delta)
	
	move_and_slide()

func update_capsule_collision() -> void:
	if slide_component.is_sliding:
		standing_collision.disabled = true
		crouching_collision.disabled = false
	else:
		standing_collision.disabled = false
		crouching_collision.disabled = true
		
func check_if_alive():
	if health_component.is_dead:
		movement_enabled = false
		movement_component.stop_movement(self)
		animation_component.handle_death_animation()
	else:
		movement_enabled = true

func respawn(delta:float):
	if health_component.respawn_ready:
		pixelation_completed=false
		health_component.respawn()
		position = spawn_point
		check_if_alive()
	
func update_spawn_point(new_spawn_point : Vector2):
	spawn_point = new_spawn_point
	
func pixelate(delta:float) -> void:
	if(pixelation_completed == false):
		if (pixel_size <= 0.001):
			flip = 1
			
		elif (pixel_size >= 0.02):
			flip = -1
			
		pixel_size += delta * pixel_size_delta * flip
		pixelation.get_material().set_shader_parameter("pixel_size", pixel_size)
		
		if (pixel_size <= 0.001):
			pixelation_completed = true

func play_footstep_sound():
	footstep_audio.pitch_scale = randf_range(0.8,1.2)
	footstep_audio.play()


func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.animation == "run":
		if $AnimatedSprite2D.frame in footstep_anim_frames:
			play_footstep_sound()
			
func toggle_pause_game():
	if get_tree().paused == false:
		var instance: PauseMenu = menu.instantiate()
		get_tree().current_scene.add_child(instance)
		get_tree().paused = true
		
	else:
		get_tree().paused = false
