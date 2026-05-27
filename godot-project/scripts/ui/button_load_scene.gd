extends CustomButton

@export var scene : PackedScene

func on_pressed() -> void:
	get_tree().change_scene_to_file(str(scene.resource_path))
