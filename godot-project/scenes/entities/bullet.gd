extends Node2D

const SPEED = 200

var lifetime = 10

func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * SPEED * delta
	
	lifetime -= delta
	if lifetime <= 0:
		queue_free()
