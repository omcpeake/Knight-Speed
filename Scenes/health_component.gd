class_name HealthComponent
extends Node

@export_subgroup("Nodes")
@export var respawn_timer: Timer

@export_subgroup("Settings")
@export var max_hp: float = 10
var current_hp: float = max_hp
var is_dead: bool =  false
@export var can_respawn: bool = false
@export var respawn_delay: float = 2

func take_damage(damage: float) -> void:
	current_hp -= damage
	if current_hp <= 0: 
		handle_death()
	
func heal(healing: float) -> void:
	current_hp += healing
	if current_hp >= max_hp:
		current_hp = max_hp
		
func kill() -> void:
	handle_death()
	
func handle_death() ->void:
	current_hp = 0
	is_dead = true
	if can_respawn:
		respawn_timer.wait_time = respawn_delay
		respawn_timer.start()

func respawn() -> void:
	#TODO implement
	print("pretend you respawned")

func _on_respawn_timer_timeout():
	respawn()
