class_name Checkpoint
extends Area2D

var location : Vector2 = self.position

func _on_body_entered(body:CharacterBody2D):
	if body is Player:
		var player : Player = body
		save_spawn_point(player)

func save_spawn_point(player : Player) -> void:
	player.update_spawn_point(location)
