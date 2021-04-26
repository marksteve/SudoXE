extends RigidBody

signal depth_changed(depth, velocity)
signal destroyed

const TERMINAL_VELOCITY = -100
const BOOST = 1.0
onready var top_rocket = $TopRocket
onready var bottom_rocket = $BottomRocket
onready var right_rocket = $RightRocket
onready var left_rocket = $LeftRocket
onready var sfx_destroy = $SFXDestroy
onready var sfx_rocket = $SFXRocket
var is_destroyed = false

func apply_rotation(position: Vector3):
	return position.rotated(Vector3(0, 0, 1.0), self.rotation.z)

func _physics_process(delta):
	if is_destroyed:
		return
		
	if Input.is_action_pressed("ui_up"):
		apply_impulse(
			apply_rotation(top_rocket.translation),
			apply_rotation(Vector3(0, -BOOST, 0)))
	elif Input.is_action_pressed("ui_down"):
		apply_impulse(
			apply_rotation(bottom_rocket.translation),
			apply_rotation(Vector3(0, BOOST, 0)))
		
	if Input.is_action_pressed("ui_right"):
		apply_impulse(
			apply_rotation(right_rocket.translation),
			apply_rotation(Vector3(-BOOST, 0, 0)))
	elif Input.is_action_pressed("ui_left"):
		apply_impulse(
			apply_rotation(left_rocket.translation),
			apply_rotation(Vector3(BOOST, 0, 0)))

	top_rocket.firing = Input.is_action_pressed("ui_up")
	bottom_rocket.firing = Input.is_action_pressed("ui_down")
	right_rocket.firing = Input.is_action_pressed("ui_right")
	left_rocket.firing = Input.is_action_pressed("ui_left")
	
	if self.linear_velocity.y < TERMINAL_VELOCITY:
		self.linear_velocity.y = TERMINAL_VELOCITY
	
	emit_signal("depth_changed", -self.translation.y, -self.linear_velocity.y)

func _on_Ship_body_entered(body):
	if is_destroyed:
		return
	
	sfx_destroy.play(1)
	emit_signal("destroyed")
	is_destroyed = true
	
	for rocket in [
		top_rocket,
		bottom_rocket,
		right_rocket,
		left_rocket,
	]:
		rocket.destroy()
		
func _on_UI_screen_changed(screen):
	if screen == "title":
		reset()

func reset():
	self.translation = Vector3(0, 20, 0)
	self.rotation = Vector3(0, 0, 0)
	self.linear_velocity = Vector3(0, 0, 0)
	self.angular_velocity = Vector3(0, 0, 0)
	
	is_destroyed = false
	
	for rocket in [
		top_rocket,
		bottom_rocket,
		right_rocket,
		left_rocket,
	]:
		rocket.reset()
