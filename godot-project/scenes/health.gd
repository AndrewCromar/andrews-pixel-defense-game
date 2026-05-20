extends Sprite2D

func _process(_delta: float) -> void:
	if Global.health <= 0: pass
	modulate.a = 1 - (Global.health / Global.max_health)
