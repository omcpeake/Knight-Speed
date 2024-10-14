class_name HealthComponent
extends Node

@export_subgroup("Settings")
@export var max_hp: float = 10
var current_hp: float = max_hp
var is_dead: bool =  false


func take_damage(damage: float) -> void:
	current_hp -= damage
	if current_hp <= 0: 
		current_hp = 0
		is_dead = true
	
func heal(healing: float) -> void:
	current_hp += healing
	if current_hp >= max_hp:
		current_hp = max_hp
		
func kill() -> void:
	current_hp = 0
	is_dead = true
