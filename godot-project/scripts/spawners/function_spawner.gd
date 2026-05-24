extends Spawner

var time : float

func _process(delta: float) -> void:
	time += delta
	spawn_rate = function(time)
	
	super(delta)

func function(x : float) -> float:
	return 1.0 / (((-cos(x) + 1.5) / 3.0) * (2.0 ** (x / 50.0)))
