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

func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.position = position + Vector2.RIGHT.rotated(rotation) * 37
	bullet.rotation = rotation
	get_parent().add_child(bullet)
	
	_play_random_shoot_sound()


func _play_random_shoot_sound() -> void:
	var random_index = randi() % shoot_sounds.size()
	audio_player.stream = shoot_sounds[random_index]
	audio_player.play()
