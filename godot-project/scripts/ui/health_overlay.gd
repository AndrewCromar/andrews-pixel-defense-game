extends Sprite2D

@export var scene : PackedScene

func _process(_delta: float) -> void:
	if Global.HEALTH <= 0:
		get_tree().change_scene_to_file(str(scene.resource_path))
	
	modulate.a = 1.0 - (float(Global.HEALTH) / Global.starting_health)
