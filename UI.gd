extends MarginContainer

signal screen_changed(screen)

onready var title_screen = $TitleScreen
onready var game_over = $GameOver
onready var hud_depth = $HUD/Depth
onready var hud_velocity = $HUD/Velocity
var screen = ""

func change_screen(new_screen: String):
	screen = new_screen
	emit_signal("screen_changed", new_screen)
	get_tree().paused = screen == "title"
	title_screen.visible = screen == "title"
	game_over.visible = screen == "game_over"
	hud_depth.visible = screen == "game"
	hud_velocity.visible = screen == "game"

func _ready():
	randomize()
	change_screen("title")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if screen == "title":
			change_screen("game")
		elif screen == "game_over":
			change_screen("title")

func _on_Ship_depth_changed(depth, velocity):
	hud_depth.text = "%.3f m" % depth
	hud_velocity.text = "%3.f m/s" % velocity

func _on_Ship_destroyed():
	change_screen("game_over")
