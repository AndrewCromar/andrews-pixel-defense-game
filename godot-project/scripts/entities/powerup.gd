extends MovingEntity

@export var die_sounds : Array[AudioStream] = []

@onready var particles : CPUParticles2D = $CPUParticles2D
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var hitbox : Area2D = $Area2D

var side : int

func _ready() -> void:
	hitbox.area_entered.connect(on_collect)
	
	match side:
		0, 1:
			end_position = Vector2(-position.y, position.x)
		2, 3:
			end_position = Vector2(position.y, -position.x)

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
