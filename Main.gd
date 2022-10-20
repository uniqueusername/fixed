extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	# sets color of non-native aspect ratio bars to white
	var black_bar_texture = preload("res://sprites/black_bars.png")
	var t_id = black_bar_texture.get_rid()
	VisualServer.black_bars_set_images(t_id, t_id, t_id, t_id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
