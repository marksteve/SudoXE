extends Spatial

onready var boulders = [
	preload("res://Boulder1.tscn"),
	preload("res://Boulder2.tscn"),
	preload("res://Boulder3.tscn"),
]

func rand_velocity(factor: float):
	return factor * (2 * randf() - 1)

func _ready():
	randomize()

func _on_Ship_depth_changed(depth, velocity):
	if depth > -100:
		return
	if get_child_count() == 0:
		var boulder: RigidBody = boulders[randi() % len(boulders)].instance()
		boulder.translation.x = randf() * 30.0 - 20.0
		boulder.translation.y = depth + 50.0
		boulder.angular_velocity = Vector3(
			rand_velocity(PI),
			rand_velocity(PI),
			rand_velocity(PI)
		)
		boulder.gravity_scale = 1.5
		boulder.linear_velocity = Vector3(0, -velocity, 0)
		boulder.scale = Vector3(0.5, 0.5, 0.5)
		add_child(boulder)
	else:
		for boulder in get_children():
			if boulder.translation.y < depth - 10:
				boulder.queue_free()