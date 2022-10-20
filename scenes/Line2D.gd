extends Line2D

var next_level
var next_level_path = "res://scenes/Level2.tscn"
var border_points
var next_points
var moving_points

func _ready():
	# config line
	round_precision = 0
	default_color = Color(0, 0, 0, 1)
	width = 4
	border_points = get_children()
	
	next_points = [];
	moving_points = []
	
	next_level = load(next_level_path)
	next_level = next_level.instance()
	for node in next_level.get_children():
		next_points.append(node.get_name())
	
	for point in border_points:
		add_point(point.position)
		moving_points.append(false)
	

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		for point in border_points:
			if next_points.has(point.get_name()):
				var index = border_points.find(point)
				if (get_point_position(index) != next_level.get_point_position(index)):
					moving_points[index] = true
				
	for n in border_points.size():
		if moving_points[n]:
			move_point(n, border_points[n].position, next_level.get_children()[n].position)

				
func move_point(index, pos1, pos2):
	var curr_pos = get_point_position(index)
	if curr_pos.distance_to(pos2) >= 1:
		set_point_position(index, curr_pos + ((pos2 - curr_pos) / 7))
	else:
		get_tree().change_scene(next_level_path)
