extends RigidBody

signal destroyed

const BOOST = 1.0
onready var top_rocket = $TopRocket
onready var top_rocket_particles = $TopRocket/Particles
onready var top_rocket_light = $TopRocket/SpotLight
onready var bottom_rocket = $BottomRocket
onready var bottom_rocket_particles = $BottomRocket/Particles
onready var bottom_rocket_light = $BottomRocket/SpotLight
onready var right_rocket = $RightRocket
onready var right_rocket_particles = $RightRocket/Particles
onready var right_rocket_light = $RightRocket/SpotLight
onready var left_rocket = $LeftRocket
onready var left_rocket_particles = $LeftRocket/Particles
onready var left_rocket_light = $LeftRocket/SpotLight
var is_destroyed = false

func apply_rotation(position: Vector3):
	return position.rotated(Vector3(0, 0, 1.0), self.rotation.z)

func _physics_process(delta):
	if is_destroyed:
		return
		
	if Input.is_action_pressed("ui_up"):
		apply_impulse(apply_rotation(top_rocket.translation), apply_rotation(Vector3(0, -BOOST, 0)))
		top_rocket_light.light_energy = lerp(top_rocket_light.light_energy, 16, 0.5)
	elif Input.is_action_pressed("ui_down"):
		apply_impulse(apply_rotation(bottom_rocket.translation), apply_rotation(Vector3(0, BOOST, 0)))
		bottom_rocket_light.light_energy = lerp(bottom_rocket_light.light_energy, 16, 0.5)
		
	if Input.is_action_pressed("ui_right"):
		apply_impulse(apply_rotation(right_rocket.translation), apply_rotation(Vector3(-BOOST, 0, 0)))
		right_rocket_light.light_energy = lerp(right_rocket_light.light_energy, 16, 0.5)
	elif Input.is_action_pressed("ui_left"):
		apply_impulse(apply_rotation(left_rocket.translation), apply_rotation(Vector3(BOOST, 0, 0)))
		left_rocket_light.light_energy = lerp(left_rocket_light.light_energy, 16, 0.5)

	top_rocket_particles.emitting = Input.is_action_pressed("ui_up")
	bottom_rocket_particles.emitting = Input.is_action_pressed("ui_down")
	right_rocket_particles.emitting = Input.is_action_pressed("ui_right")
	left_rocket_particles.emitting = Input.is_action_pressed("ui_left")
	
	top_rocket_light.light_energy = lerp(top_rocket_light.light_energy, 0, 0.5)
	bottom_rocket_light.light_energy = lerp(bottom_rocket_light.light_energy, 0, 0.5)
	right_rocket_light.light_energy = lerp(right_rocket_light.light_energy, 0, 0.5)
	left_rocket_light.light_energy = lerp(left_rocket_light.light_energy, 0, 0.5)

func _on_Ship_body_entered(body):
	if is_destroyed:
		return

	emit_signal("destroyed")
	is_destroyed = true
	
	for particles in [
		top_rocket_particles,
		bottom_rocket_particles,
		right_rocket_particles,
		left_rocket_particles,
	]:
		particles.emitting = true
		particles.process_material.spread = 180
		
	top_rocket_light.light_energy = 16
	bottom_rocket_light.light_energy = 16
	right_rocket_light.light_energy = 16
	left_rocket_light.light_energy = 16
		
func _on_UI_screen_changed(screen):
	if screen == "title":
		self.translation = Vector3(0, 0, 0)
		self.rotation = Vector3(0, 0, 0)
		self.linear_velocity = Vector3(0, 0, 0)
		self.angular_velocity = Vector3(0, 0, 0)
		
		is_destroyed = false
		
		for particles in [
			top_rocket_particles,
			bottom_rocket_particles,
			right_rocket_particles,
			left_rocket_particles,
		]:
			particles.emitting = false
			particles.process_material.spread = 30
			# Reset particles
			particles.amount = 0
			particles.amount = 8
			
		top_rocket_light.light_energy = 0
		bottom_rocket_light.light_energy = 0
		right_rocket_light.light_energy = 0
		left_rocket_light.light_energy = 0
