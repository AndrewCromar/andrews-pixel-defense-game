extends MovingEntity

@onready var particles : CPUParticles2D = $CPUParticles2D

func die() -> void:
	particles.reparent(get_parent())
	particles.finished.connect(particles.queue_free)
	particles.emitting = true
	
	queue_free()
