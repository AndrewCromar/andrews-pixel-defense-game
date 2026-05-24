extends MovingEntity

@export var die_sounds : Array[AudioStream] = []

@onready var particles : CPUParticles2D = $CPUParticles2D
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

func die() -> void:
	particles.reparent(get_parent())
	particles.finished.connect(particles.queue_free)
	particles.emitting = true
	
	audio_player.reparent(get_parent())
	particles.finished.connect(audio_player.queue_free)
	audio_player.stream = die_sounds.pick_random()
	audio_player.play()
	
	queue_free()
