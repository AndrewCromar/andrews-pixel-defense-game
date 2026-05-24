extends Area2D

func _ready() -> void:
	area_entered.connect(on_block)

func _process(_delta: float) -> void:
	var input_vector = Input.get_vector("left", "right", "up", "down")
	look_at(input_vector)

func on_block(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		Global.SCORE += 1
		
		area.die()
