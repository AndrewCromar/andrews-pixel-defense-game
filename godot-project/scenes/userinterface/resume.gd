extends Button

@export_file("*.tscn") var scene : String
@onready var hover_audio: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_hover)

func _on_pressed() -> void:
	Global.paused = false

func _on_hover() -> void:
	hover_audio.play()
