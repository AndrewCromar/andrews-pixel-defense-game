extends Button
class_name CustomButton

@export var hover_sound : AudioStream

@onready var player : AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	player.stream = hover_sound
	
	pressed.connect(on_pressed)
	mouse_entered.connect(on_hovered)

func on_pressed() -> void:
	pass

func on_hovered() -> void:
	player.play()
