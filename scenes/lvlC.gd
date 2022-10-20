extends Line2D

const TICK = 0.2 # moves by 100/TICK percent each frame
const TOLERANCE = TICK * 3 # margin before switching
const FINAL_PATH = "res://scenes/lvlC.tscn"

var final_level # final state level instance
var final_points = [] # array of final point positions
var point_container
var animating

func _ready():
	point_container = get_node("Points")
	
	# draw original state
	config_line()
	trace()
	
	final_level = load(FINAL_PATH)
	final_level = final_level.instance()
	animating = false
	
	for point in final_level.get_node("Points").get_children():
		final_points.append(point.position)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"): animating = true
	
	if animating:
		var complete = true # true by end of loop if animation is complete
		for i in get_point_count():
			complete = move_point(i, final_points[i], delta)
	
		# if animation is complete, switch scenes
		if complete:
			get_tree().change_scene(FINAL_PATH)
			
	get_node("StaticBody2D/CollisionPolygon2D").set_polygon(points)

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
