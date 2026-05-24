extends Node2D

@export var strength : float = 5
@export var speed : float = 0.05

var timer : float
var offset : Vector2

func _process(delta: float) -> void:
	position = offset
	
	Global.CAMERA_SHAKE_DURATION -= delta
	if Global.CAMERA_SHAKE_DURATION <= 0:
		offset = Vector2.ZERO
		return
	
	timer -= delta
	if timer <= 0:
		timer = speed
		offset = Vector2.RIGHT.rotated(randf() * TAU) * (randf() * strength)
