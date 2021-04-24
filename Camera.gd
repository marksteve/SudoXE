extends Camera

func _process(delta):
	self.translation.y = lerp(self.translation.y, $"../Ship".translation.y, 0.8)
