extends Area2D

@export var menu: PackedScene

func _on_body_entered(body):
	if body is Player:
		var playerinst: Player = body
		playerinst.movement_enabled = false
		playerinst.velocity = Vector2(0,0)
		GlobalGameTimer.stopped = true
		var instance: GameCompletedMenu = menu.instantiate()
		get_tree().current_scene.add_child(instance)
