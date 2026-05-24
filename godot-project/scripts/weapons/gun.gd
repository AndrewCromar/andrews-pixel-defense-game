extends Node2D

@export var bullet : PackedScene

@onready var shoot_position : Node2D = $ShootPosition

var timer : float

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	timer -= delta
	if timer <= 0:
		timer = Global.FIRE_RATE
		
		var new_bullet = bullet.instantiate()
		new_bullet.position = shoot_position.global_position
		new_bullet.end_position = Vector2.from_angle(rotation)
		get_parent().add_child(new_bullet)
