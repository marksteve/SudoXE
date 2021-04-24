extends GridMap

const TILE_SIZE = 4
const CHUNK_SIZE = 16
onready var ship = $"../Ship"
var chunks = 1

func generate_row(y: int):
	set_cell_item(-6, 0, y, 0)
	if randi() % 2 == 1:
		var x = (randi() % 11) - 6
		set_cell_item(x, 0, y, 0)
	set_cell_item(5, 0, y, 0)

func generate_chunk(chunk: int):
	for y in range((chunk - 1) * CHUNK_SIZE, chunk * CHUNK_SIZE):
		generate_row(y)

func _ready():
	generate_chunk(chunks)

func _physics_process(delta):
	if -ship.translation.y / TILE_SIZE > (chunks - 0.5) * CHUNK_SIZE:
		chunks += 1
		generate_chunk(chunks)
