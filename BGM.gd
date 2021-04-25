extends AudioStreamPlayer


func _on_UI_screen_changed(screen):
	if screen == "title":
		self.seek(0)
