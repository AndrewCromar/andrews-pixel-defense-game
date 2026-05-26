extends MovingEntity

@export var die_sounds : Array[AudioStream] = []

@onready var particles : CPUParticles2D = $CPUParticles2D
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var hitbox : Area2D = $Area2D

func _ready() -> void:
	hitbox.area_entered.connect(on_collect)

	var half : Vector2 = get_viewport().get_visible_rect().size / 2
	if abs(position.y) - half.y > abs(position.x) - half.x:
		end_position = Vector2(position.x, -position.y)
	else:
		end_position = Vector2(-position.x, position.y)

func on_collect(area : Area2D) -> void:
	if area.is_in_group("bullet"):
		Global.FIRE_RATE /= 2
		die()

func die() -> void:
	particles.reparent(get_parent())
	particles.finished.connect(particles.queue_free)
	particles.emitting = true
	
	audio_player.reparent(get_parent())
	particles.finished.connect(audio_player.queue_free)
	audio_player.stream = die_sounds.pick_random()
	audio_player.play()
	
	Global.CAMERA_SHAKE_DURATION = 0.2
	
	queue_free()
