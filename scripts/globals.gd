extends Node

var firststroke = false
var level_num = 18

var mus_files = [0,0,1,1,1,2,3,4,5,6,7,8,9,9,0,0,0,0,0,0,0,0,0,00,0,0,0,0]
var snow_effects = [0,0,0,0,0,100.250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250]
var snow_angle = [0,0,0,0,0,0,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,250,250,250,250]

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
