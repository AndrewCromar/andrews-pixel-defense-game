extends MovingEntity

@onready var hitbox : Area2D = $Area2D

func _ready() -> void:
	end_position = end_position * max(get_viewport().size.x, get_viewport().size.y)
	speed = 200
	look_at_end = true
	
	hitbox.area_entered.connect(on_block)

func on_block(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		Global.SCORE += 1
		
		area.die()
		queue_free()
