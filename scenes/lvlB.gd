extends Line2D

const TICK = 0.2 # moves by 100/TICK percent each frame
const TOLERANCE = TICK * 3 # margin before switching to final level
const TRANS_PATH = "res://scenes/lvlBC.tscn" # path to transition level

var point_container

func _ready():
	point_container = get_node("Points")
	
	config_line()
	trace()
	
	get_node("StaticBody2D/CollisionPolygon2D").set_polygon(points)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene(TRANS_PATH)

func config_line():
	round_precision = 0
	default_color = Color(0, 0, 0, 1)
	width = 4
	
func trace():
	clear_points()
	var point_nodes = point_container.get_children() # array of references to nodes
	for point in point_nodes:
		add_point(point.position)
		
# move point at index i one tick towards position goal
# returns false if still animating, true if point at goal
func move_point(point, goal, delta):
	var pos = get_point_position(point) # current position
	if abs(pos.distance_to(goal)) > TOLERANCE:
		set_point_position(point, 
			pos + (((goal - pos) / TICK) * delta)
		)
		return false
	else:
		return true
