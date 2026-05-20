extends Node2D

@export var bullet_scene : PackedScene
@export var shoot_sounds : Array[AudioStream] = []
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

var counter : float = 0.0

func _process(delta) -> void:
	look_at(get_global_mouse_position())
	
	counter -= delta
	if counter <= 0:
		counter = Global.fire_rate
		_shoot()

func _shoot_old() -> void:
	# It needs to shoot Global.bullet_spread number of bullets shotgun style in even directions.
	
	var bullet = bullet_scene.instantiate()
	bullet.position = position + Vector2.RIGHT.rotated(rotation) * 37
	bullet.rotation = rotation
	get_parent().add_child(bullet)
	
	_play_random_shoot_sound()

func _shoot() -> void:
	var bullet_count: int = Global.bullet_spread
	if bullet_count <= 0:
		return
	
	# --- Shotgun Tuning Variables ---
	var angle_step: float = deg_to_rad(8.0)    # The ideal separation between each bullet
	var max_total_arc: float = deg_to_rad(90) # The absolute widest the blast can ever get
	# --------------------------------
	
	# 1. Calculate the natural width if we used the exact angle step
	var natural_arc: float = angle_step * (bullet_count - 1)
	
	# 2. Determine the actual step to use. If natural width exceeds the max, 
	# we cap the width and squish the step size down.
	var actual_arc: float = min(natural_arc, max_total_arc)
	var final_step: float = angle_step
	
	if bullet_count > 1 and natural_arc > max_total_arc:
		final_step = max_total_arc / (bullet_count - 1)

	# 3. Fire the bullets centered around the player's current facing direction
	var start_angle: float = rotation - (actual_arc / 2.0)
	
	for i in range(bullet_count):
		var final_rotation: float = start_angle + (final_step * i)
		
		var bullet = bullet_scene.instantiate()
		bullet.position = position + Vector2.RIGHT.rotated(final_rotation) * 37
		bullet.rotation = final_rotation
		get_parent().add_child(bullet)
		
	_play_random_shoot_sound()

func _play_random_shoot_sound() -> void:
	var random_index = randi() % shoot_sounds.size()
	audio_player.stream = shoot_sounds[random_index]
	audio_player.play()
