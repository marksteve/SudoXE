extends RigidBody

const BOOST = 1.0

func apply_rotation(position: Vector3):
	return position.rotated(Vector3(0, 0, 1.0), self.rotation.z)

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		apply_impulse(apply_rotation(Vector3(0.1, -1.25, 0)), apply_rotation(Vector3(0, -BOOST, 0)))
	elif Input.is_action_pressed("ui_down"):
		apply_impulse(apply_rotation(Vector3(0.1, 1.25, 0)), apply_rotation(Vector3(0, BOOST, 0)))
		
	if Input.is_action_pressed("ui_right"):
		apply_impulse(apply_rotation(Vector3(1.25, 0.1, 0)), apply_rotation(Vector3(-BOOST, 0, 0)))
	elif Input.is_action_pressed("ui_left"):
		apply_impulse(apply_rotation(Vector3(-1.25, 0.1, 0)), apply_rotation(Vector3(BOOST, 0, 0)))

	$TopRocket/Particles.emitting = Input.is_action_pressed("ui_up")
	$BottomRocket/Particles.emitting = Input.is_action_pressed("ui_down")
	$RightRocket/Particles.emitting = Input.is_action_pressed("ui_right")
	$LeftRocket/Particles.emitting = Input.is_action_pressed("ui_left")
