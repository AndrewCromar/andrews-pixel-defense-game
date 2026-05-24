extends Label

@export var prefix : String
@export var sufix : String

func _process(_delta: float) -> void:
	text = prefix + str(Global.SCORE) + sufix
