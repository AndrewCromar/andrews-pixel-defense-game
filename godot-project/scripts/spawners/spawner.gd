extends Node2D
class_name Spawner

@export var distance_outside_screen : float = 30
@export var entities : Array[PackedScene] = []

@export var spawn_rate : float = 1
var timer : float = 0

var side : int = 0

func _process(delta: float) -> void:
	timer -= delta
	
	if timer <= 0:
		timer = spawn_rate
		
		spawn()

func spawn() -> void:
	var new_entity = entities.pick_random().instantiate()
	new_entity.position = get_random_perimeter_position()
	add_child(new_entity)

func get_random_perimeter_position(padding: float = 30.0) -> Vector2:
	var screen_size : Vector2 = get_viewport().get_visible_rect().size
	
	var half_x : float = screen_size.x / 2.0
	var half_y : float = screen_size.y / 2.0
	
	var result : Vector2 = Vector2.ZERO
	side = randi() % 4
	
	match side:
		0: # Top.
			result.y = -half_y - padding
			result.x = randf_range(-half_x - padding, half_x + padding)
		1: # Bottom.
			result.y = half_y + padding
			result.x = randf_range(-half_x - padding, half_x + padding)
		2: # Left.
			result.x = -half_x - padding
			result.y = randf_range(-half_y - padding, half_y + padding)
		3: # Right.
			result.x = half_x + padding
			result.y = randf_range(-half_y - padding, half_y + padding)
			
	return result
