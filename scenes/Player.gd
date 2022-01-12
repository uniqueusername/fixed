extends KinematicBody2D

const GRAV = 4000
const SPEED = 700
const JUMP_POWER = 1200
const MAX_GRACE = 8 # number of frames of ledge forgiveness

var vel = Vector2()
var grace = MAX_GRACE

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	vel.y += delta * GRAV

	if !is_on_floor():
		grace -= delta
	else:
		grace = MAX_GRACE * delta

	get_input()
	vel = move_and_slide(vel, Vector2(0, -1))

func get_input():
	vel.x = 0
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_just_pressed("ui_up")

	if jump && grace > 0:
		vel.y = -JUMP_POWER
		grace = 0
	if right:
		vel.x += SPEED
	if left:
		vel.x -= SPEED
