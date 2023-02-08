extends Spatial

const SEGMENT_HEIGHT = 50.0
onready var segments = [$Segment1, $Segment2, $Segment3, $Segment4]
var curr_segment = 0

func update_segments():
	var segment = segments[curr_segment % len(segments)]
	segment.translation.y = -(curr_segment * SEGMENT_HEIGHT)
	
func _ready():
	update_segments()
	
func _on_Ship_depth_changed(depth, _velocity):
	if depth / SEGMENT_HEIGHT > curr_segment:
		curr_segment += 1
		update_segments()

func _on_UI_screen_changed(screen):
	if screen == "title":
		curr_segment = 0
		update_segments()
