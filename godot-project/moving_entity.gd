extends Node2D
class_name MovingEntity

var end_position : Vector2 = Vector2.ZERO
var speed : float = 75
var look_at_end : bool = false

func _process(delta: float) -> void:
	position = position.move_toward(end_position, speed * delta)
	if look_at_end: look_at(end_position)
