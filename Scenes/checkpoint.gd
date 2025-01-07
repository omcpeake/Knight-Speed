class_name Checkpoint
extends Area2D

@export_subgroup("Nodes")
@export var sprite: AnimatedSprite2D
@export var checkpoint_audio: AudioStreamPlayer2D
var location : Vector2 = self.position
var activated : bool = false

func _on_body_entered(body:CharacterBody2D):
	if body is Player:
		var player : Player = body
		save_spawn_point(player)
		if(activated == false):
			sprite.play("active")
			checkpoint_audio.play()

func save_spawn_point(player : Player) -> void:
	player.update_spawn_point(self.position)
