extends Area2D

func _ready() -> void:
	area_entered.connect(on_block)

func on_block(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		Global.HEALTH -= 1
		
		area.die()
