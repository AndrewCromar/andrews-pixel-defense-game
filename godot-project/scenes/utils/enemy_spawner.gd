extends Node2D

@export var enemy_scene : PackedScene

const SPAWN_OUTER_RADIUS : float = 600
const SPAWN_INNER_RADIUS : float = 300

var counter : float = 0
var time : float = 0

func _process(delta: float) -> void:
	time += delta
	counter -= delta
	if counter <= 0:
		counter = 1.0 / _difficulty_curve(time)
		_spawn_enemy()

func _spawn_enemy() -> void:
	var angle = randf() * TAU
	var random_distance = lerp(SPAWN_INNER_RADIUS, SPAWN_OUTER_RADIUS, sqrt(randf()))
	var point = Vector2.from_angle(angle) * random_distance
	
	var enemy = enemy_scene.instantiate()
	enemy.position = point
	add_child(enemy)

func _difficulty_curve(x : float) -> float:
	return ((-cos(x) + 1.5) / 3.0) * (2.0 ** (x / 50.0))
