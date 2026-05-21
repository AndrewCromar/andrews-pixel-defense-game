extends Control

var camera_zoom : Vector2
var camera : Camera2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	camera = get_viewport().get_camera_2d()
	camera_zoom = camera.zoom

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		Global.paused = !Global.paused

func _process(_delta: float) -> void:
	if Global.paused:
		Engine.time_scale = 0.0
		visible = true
		camera.zoom = Vector2(1, 1)
	else:
		Engine.time_scale = 1.0
		visible = false
		camera.zoom = camera_zoom
