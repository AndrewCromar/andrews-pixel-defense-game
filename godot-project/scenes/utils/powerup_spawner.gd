extends Node2D

@export var powerups : Array[PackedScene] = []

const SPAWN_TIME : float = 20.0
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
	
	var screen_size = get_viewport_rect().size
	var spawn_position = Vector2.ZERO
	
	var side = randi() % 4
	match side:
		0:
			spawn_position.x = randf_range(0, screen_size.x)
			spawn_position.y = -MARGIN
		1:
			spawn_position.x = randf_range(0, screen_size.x)
			spawn_position.y = screen_size.y + MARGIN
		2:
			spawn_position.x = -MARGIN
			spawn_position.y = randf_range(0, screen_size.y)
		3:
			spawn_position.x = screen_size.x + MARGIN
			spawn_position.y = randf_range(0, screen_size.y)
		
	var powerup_instance = powerups.pick_random().instantiate()
	powerup_instance.position = spawn_position
	powerup_instance.side = side
	add_child(powerup_instance)
