extends RigidBody

signal destroyed

const BOOST = 1.0
onready var top_rocket_particles = $TopRocket/Particles
onready var bottom_rocket_particles = $BottomRocket/Particles
onready var right_rocket_particles = $RightRocket/Particles
onready var left_rocket_particles = $LeftRocket/Particles
var is_destroyed = false

func apply_rotation(position: Vector3):
	return position.rotated(Vector3(0, 0, 1.0), self.rotation.z)

func _physics_process(delta):
	if is_destroyed:
		return
		
	if Input.is_action_pressed("ui_up"):
		apply_impulse(apply_rotation(Vector3(0, -1.25, 0)), apply_rotation(Vector3(0, -BOOST, 0)))
	elif Input.is_action_pressed("ui_down"):
		apply_impulse(apply_rotation(Vector3(0, 1.25, 0)), apply_rotation(Vector3(0, BOOST, 0)))
		
	if Input.is_action_pressed("ui_right"):
		apply_impulse(apply_rotation(Vector3(1.25, 0.1, 0)), apply_rotation(Vector3(-BOOST, 0, 0)))
	elif Input.is_action_pressed("ui_left"):
		apply_impulse(apply_rotation(Vector3(-1.25, 0.1, 0)), apply_rotation(Vector3(BOOST, 0, 0)))

	top_rocket_particles.emitting = Input.is_action_pressed("ui_up")
	bottom_rocket_particles.emitting = Input.is_action_pressed("ui_down")
	right_rocket_particles.emitting = Input.is_action_pressed("ui_right")
	left_rocket_particles.emitting = Input.is_action_pressed("ui_left")

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
