extends MarginContainer

onready var title_screen = $TitleScreen
onready var game_over = $GameOver
onready var depth = $Depth
var screen = "title"

func _ready():
	get_tree().paused = true

func _input(event):
	match screen:
		"title":
			if event.is_action_pressed("ui_accept"):
				get_tree().paused = false
				title_screen.visible = false
				depth.visible = true
				screen = "game"
		"game":
			pass
		"game_over":
			if event.is_action_pressed("ui_accept"):
				get_tree().paused = true
				game_over.visible = false
				title_screen.visible = true
				depth.visible = false
				screen = "title"


func _on_Ship_destroyed():
	game_over.visible = true
	screen = "game_over"
