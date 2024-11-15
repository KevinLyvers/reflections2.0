extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	load_level(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func load_level(num):
	var next_level_path = "res://scenes/Levels/Level" + str(num) + ".tscn"
	var packed_scene = load(next_level_path)
			
	var instance = packed_scene.instantiate()
	add_child(instance) # Add it as a child of this node
	
func del_level(num):
	for child in get_children():
		if child.name != "Music_Manager":
			child.queue_free()
			
# to level 
func change_level(num):
	del_level(num - 1)
	load_level(num)
	
func fade_in_audio_call(fade_in_duration: float, layer: int):
	$Music_Manager.fade_in_audio(fade_in_duration, layer)
	
