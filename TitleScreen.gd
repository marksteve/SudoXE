extends CenterContainer

func _ready():
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().paused = false
		self.visible = false
		$"../Depth".visible = true
