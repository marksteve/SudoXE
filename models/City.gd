extends Spatial

onready var explosion = $Explosion
onready var explosion_light = $Explosion/OmniLight
onready var sfx_explode = $SFXExplode

func _on_Ship_depth_changed(depth, velocity):
	var scale = min((20 + depth) / 20, 2.0)
	explosion.scale = Vector3(scale, scale, scale)
	explosion.rotation.y = PI * scale / 2
	explosion_light.omni_range = scale * 100


func _on_UI_screen_changed(screen):
	if screen == "title":
		explosion.scale = Vector3(0, 0, 0)
		explosion_light.omni_range = 0
		sfx_explode.play(0)
