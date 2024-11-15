extends Node

var firststroke = false
var level_num = 1

var mus_files = [0,0,1,1,1,2]
var snow_effects = [0,0,0,0,0,100]
var snow_angle = [0,0,0,0,0,0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_level(num):
	var next_level_path = "res://scenes/Levels/Level" + str(num) + ".tscn"
	var packed_scene = load(next_level_path)
			
	var instance = packed_scene.instantiate()
	$".".add_child(instance) # Add it as a child of this node
