extends Button
class_name CustomButton

@export var hover_sound : AudioStream

@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	audio_player.stream = hover_sound
	
	pressed.connect(on_pressed)
	mouse_entered.connect(on_hovered)

func on_pressed() -> void:
	pass

func on_hovered() -> void:
	audio_player.play()
