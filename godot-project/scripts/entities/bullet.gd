extends MovingEntity

@onready var hitbox : Area2D = $Area2D

func _ready() -> void:
	end_position = end_position * max(get_viewport().size.x, get_viewport().size.y)
	speed = 200
	look_at_end = true
	
	hitbox.area_entered.connect(on_block)

func on_block(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.die()
		Global.SCORE += 1
		queue_free()
