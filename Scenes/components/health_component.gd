class_name HealthComponent
extends Node

@export_subgroup("Nodes")
@export var respawn_timer: Timer

@export_subgroup("Settings")
@export var max_hp: float = 10
var current_hp: float = 1
var is_dead: bool =  false
@export var can_respawn: bool = false
@export var respawn_delay: float = 1

@export_subgroup("Audio")
@export var death_audio: AudioStreamPlayer
@export var respawn_audio: AudioStreamPlayer
var respawn_ready : bool = false

func _ready():
	current_hp = max_hp

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
	death_audio.play()
	if can_respawn:
		respawn_timer.wait_time = respawn_delay
		respawn_timer.start()

func respawn() -> void:
	respawn_ready = false
	current_hp = max_hp
	is_dead = false
	respawn_audio.play()

func _on_respawn_timer_timeout():
	respawn_ready = true
