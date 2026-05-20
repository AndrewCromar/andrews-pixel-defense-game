extends Node2D

@export var powerups : Array[PackedScene] = []

const SPAWN_TIME : float = 5.0
const MARGIN : float = 50.0 

var counter : float = 0.0

func _process(delta: float) -> void:
	counter -= delta
	if counter <= 0:
		counter = SPAWN_TIME
		_spawn_random_powerup()

func _spawn_random_powerup() -> void:
	if powerups.is_empty():
		return
	
	var half_screen = get_viewport_rect().size / 2.0
	var spawn_position = Vector2.ZERO
	
	var side = randi() % 4
	match side:
		0:
			spawn_position.x = randf_range(-half_screen.x, half_screen.x)
			spawn_position.y = -half_screen.y - MARGIN
		1:
			spawn_position.x = randf_range(-half_screen.x, half_screen.x)
			spawn_position.y = half_screen.y + MARGIN
		2:
			spawn_position.x = -half_screen.x - MARGIN
			spawn_position.y = randf_range(-half_screen.y, half_screen.y)
		3:
			spawn_position.x = half_screen.x + MARGIN
			spawn_position.y = randf_range(-half_screen.y, half_screen.y)
		
	var powerup_instance = powerups.pick_random().instantiate()
	powerup_instance.position = spawn_position
	powerup_instance.side = side
	add_child(powerup_instance)
