extends Spatial

const LEVEL_DEPTH = 1000
onready var ship = $"../Ship" # TODO: refactor
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
	if depth < 100:
		return
	if get_child_count() == 0:
		var boulder: RigidBody = boulders[randi() % len(boulders)].instance()
		boulder.translation.x = ship.translation.x + randf() * 4.0 - 2.0
		boulder.translation.y = -(depth - 100.0)
		boulder.angular_velocity = Vector3(
			rand_velocity(PI),
			rand_velocity(PI),
			rand_velocity(PI)
		)
		boulder.linear_velocity = Vector3(0, -velocity, 0)
		
		var level = floor(depth / LEVEL_DEPTH)
		boulder.gravity_scale = min(1.5 + level * 0.1, 3.0)
		var scale = min(0.5 + level * 0.1, 1.5)
		boulder.scale = Vector3(scale, scale, scale)
		
		add_child(boulder)
	else:
		for boulder in get_children():
			if boulder.translation.y < -(depth + 10):
				boulder.queue_free()
