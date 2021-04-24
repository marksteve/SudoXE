extends GridMap

const TILE_SIZE = 4
const CHUNK_SIZE = 16
onready var ship = $"../Ship"
onready var ui_depth = $"../UI/Depth"
var chunks = 1

func generate_row(y: int):
	for x in range(-6, 6):
		set_cell_item(x, -1, y, 1)
	set_cell_item(-6, 0, y, 1)
	set_cell_item(5, 0, y, 1)
	if randi() % int(max(20 - chunks, 1)) == 1:
		var x = (randi() % 10) - 5
		set_cell_item(x, 0, y, 0)

func generate_chunk(chunk: int):
	for y in range((chunk - 1) * CHUNK_SIZE, chunk * CHUNK_SIZE):
		generate_row(y)

func _ready():
	generate_chunk(chunks)

func _physics_process(delta):
	if -ship.translation.y / TILE_SIZE > (chunks - 0.5) * CHUNK_SIZE:
		chunks += 1
		generate_chunk(chunks)

func _process(delta):
	if not ship.is_destroyed:
		ui_depth.text = "%.3f m" % ship.translation.y

func _on_UI_screen_changed(screen):
	if screen == "title":
		clear()
		chunks = 1
		generate_chunk(chunks)
