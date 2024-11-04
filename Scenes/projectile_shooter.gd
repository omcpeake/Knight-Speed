extends Node2D

@export_subgroup("Nodes")
@export var projectile: PackedScene
@export var fire_timer: Timer
@export_subgroup("Settings")
@export var fire_delay: float = 5



# Called when the node enters the scene tree for the first time.
func _ready():
	fire_timer.wait_time = fire_delay
	fire_timer.start()
	
	
func fire_projectile() -> void:
	var instance: Projectile = projectile.instantiate()
	if instance is Projectile:
		instance.direction = rotation
		instance.spawn_pos = global_position
		instance.spawn_rot = rotation
		instance.z_index = z_index -1
		get_tree().current_scene.add_child(instance)
	

func _on_timer_timeout():
	fire_projectile()
