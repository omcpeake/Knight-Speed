extends Area2D


@export_subgroup("Nodes")
@export var killzone_component: KillzoneComponent


func _on_body_entered(body):
	if body is Player:
		killzone_component.kill_unit(body)
