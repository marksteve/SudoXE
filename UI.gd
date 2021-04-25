extends MarginContainer

signal screen_changed(screen)

onready var title_screen = $TitleScreen
onready var game_over = $GameOver
onready var depth_label = $Depth
var screen = ""

func change_screen(new_screen: String):
	screen = new_screen
	emit_signal("screen_changed", new_screen)

func update_screen():
	get_tree().paused = screen == "title"
	title_screen.visible = screen == "title"
	game_over.visible = screen == "game_over"
	depth_label.visible = screen == "game"	

func _ready():
	randomize()
	change_screen("title")
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if screen == "title":
			change_screen("game")
		elif screen == "game_over":
			change_screen("title")
		call_deferred("update_screen")

func _on_Ship_depth_changed(depth):
	depth_label.text = "%.3f m" % depth

func _on_Ship_destroyed():
	game_over.visible = true
	change_screen("game_over")
