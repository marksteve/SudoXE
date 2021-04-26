tool
extends Spatial

onready var particles = $Particles
onready var spot_light = $SpotLight
onready var omni_light = $OmniLight
onready var sfx_rocket = $SFXRocket
onready var sfx_rocket_end = $SFXRocketEnd
export var firing = false
export var destroyed = false
var prev_firing = false
var light_energy = 0

func reset():
	firing = false
	destroyed = false
	spot_light.light_energy = 0
	omni_light.light_energy = 0
	particles.restart()

func destroy():
	firing = false
	destroyed = true

func _process(delta):
	if sfx_rocket and prev_firing != firing:
		if prev_firing:
			sfx_rocket.stop()
			sfx_rocket_end.play(6.5)
		else:
			sfx_rocket.play()
		prev_firing = firing
		
	light_energy = 8 if (firing or destroyed) else 0
	if spot_light:
		spot_light.light_energy = lerp(spot_light.light_energy, light_energy, 0.5)
	if omni_light:
		omni_light.light_energy = lerp(omni_light.light_energy, light_energy, 0.5)
	if particles:
		particles.emitting = firing or destroyed
		particles.process_material.spread = 180 if destroyed else 15
