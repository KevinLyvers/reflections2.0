extends Node2D

var child_nodes : Array = []

func _ready():
	#print(get_topmost_parent(self).get_children())
	#print(get_topmost_parent(self))
	#get_topmost_parent(self).fade_in_audio_call(20, mus_files[Globals.level_num])
	
	get_node("/root/Main/Music_Manager").fade_in_audio(20, Globals.mus_files[Globals.level_num])
	get_node("/root/Main/Music_Manager").play_voiceover_audio(-1)
	
	if Globals.snow_effects[Globals.level_num] == 0:
		$CPUParticles2D.set_emitting(false)
	else:
		$CPUParticles2D.set_amount(Globals.snow_effects[Globals.level_num])
		$CPUParticles2D.set_emitting(true)
		$CPUParticles2D.rotation_degrees  = Globals.snow_angle[Globals.level_num]
	
	#TextManager.start_dialog(Vector2(0,100), [""])
	
	
	var map = get_node("Mirror")
	var children = map.get_children()
	for child in children:
		if child is Sprite2D:
			child_nodes.append(child)
	
	#MusicManager

# confused
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in child_nodes:
		if i.won == false:
			return
	next_level_load()

func next_level_load():
	
	Globals.load_level(Globals.level_num + 1)
	
	Globals.level_num += 1

	self.queue_free()
	
func get_topmost_parent(node: Node) -> Node:
	if node.name == "Main":
		return node
	
	while node.get_parent() != null:
		if node.name == "Main":
			return node
		node = node.get_parent()
	return node
