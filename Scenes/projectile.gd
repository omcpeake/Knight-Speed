class_name Projectile
extends CharacterBody2D

@export_subgroup("Nodes")
@export var killzone_component: KillzoneComponent
@export var ttl_timer: Timer
@export var CollisionSound: AudioStreamPlayer2D
@export_subgroup("Settings")
@export var speed: float = 300
@export var damage: float = 5
@export var time_to_live: float = 4

var direction: float
var spawn_pos: Vector2
var spawn_rot: float
var zdex: int

func _ready():
	global_position = spawn_pos
	global_rotation = spawn_rot
	z_index = zdex
	ttl_timer.start(time_to_live)
	
func _physics_process(delta):
	velocity = Vector2(0,-speed).rotated(direction)
	move_and_slide()
	
func _on_area_2d_body_entered(body):
	if body is Player:
		killzone_component.damage_unit(body, damage)
	CollisionSound.play()
	self.visible = false
	## completely removes collison from the object, just disabling it did nothing for some reason
	var col = get_node("Area2D/CollisionShape2D")
	col.queue_free()
	#queue_free()


func _on_time_to_live_timeout():
	## destroy projectile after lifetime ends
	queue_free()

