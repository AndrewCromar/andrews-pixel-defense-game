extends Node2D

@export_file("*.tscn") var game_over_scene : String

func _ready() -> void:
	Global.paused = false
	Global.health = Global.max_health

func take_damage(amount: int):
	Global.health -= amount

	if Global.health <= 0:
		die()

func die():
	get_tree().call_deferred("change_scene_to_file", game_over_scene)
