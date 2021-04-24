extends Camera

onready var ship = $"../Ship"

func _process(delta):
	self.translation.y = lerp(self.translation.y, ship.translation.y, 0.8)
