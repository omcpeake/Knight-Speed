extends Area2D

@export_subgroup("Nodes")
@export var killzone_component: KillzoneComponent

@export_subgroup("Settings")
@export var damage: float = 5

func _on_body_entered(body):
	if body is Player:
		killzone_component.damage_unit(body, damage)
		
