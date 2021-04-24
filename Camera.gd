extends Camera

onready var ship = $"../Ship"
onready var noise = OpenSimplexNoise.new()
var noise_y = 0
var shake_decay = 0.8
var shake_amount = 0.0
var shake_max_offset = Vector2(3, 3)
var shake_max_roll = 0.1

func shake(amount: float):
	noise_y += 1
	rotation.z = shake_max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	shake_max_offset.x = shake_max_offset.x * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
	shake_max_offset.y = shake_max_offset.y * amount * noise.get_noise_2d(noise.seed * 3, noise_y)

func _ready():
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

func _process(delta):
	self.translation.y = ship.translation.y
	if shake_amount > 0.0:
		shake(shake_amount)
		shake_amount = max(shake_amount - shake_decay * delta, 0)

func _on_Ship_destroyed():
	shake_amount = 1.0
