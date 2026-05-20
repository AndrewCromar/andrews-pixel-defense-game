extends Area2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

const SPEED : float = 200

var target_position : Vector2
var side : int

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	target_position = position
	
	match side:
		0, 1:
			target_position.y *= -1
		2, 3:
			target_position.x *= -1

func _process(delta: float) -> void:
	position = position.move_toward(target_position, SPEED * delta)
	
	if abs((position - target_position).length()) < 10:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		Global.health += 1
		_die()

func _die() -> void:
	_spawn_particles()
	audio_player.play()
	
	audio_player.get_parent().remove_child(audio_player)
	get_tree().root.add_child(audio_player)
	
	var camera = get_tree().root.find_child("CameraContainer", true, false)
	if camera:
		camera.shake()
	
	queue_free()

func _spawn_particles() -> void:
	var p = %Particles.duplicate()
	get_parent().add_child(p)
	p.global_position = global_position
	p.emitting = true

	await get_tree().create_timer(1.0).timeout
	p.queue_free()
