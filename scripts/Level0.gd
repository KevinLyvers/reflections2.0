extends Node2D

var firststroke = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_topmost_parent(self).fade_in_audio_call(20, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if firststroke:
		return 
		
	if event is InputEventKey and event.is_released():	
		var main = get_topmost_parent(self)
		main.change_level(Globals.level_num)
		

func get_topmost_parent(node: Node) -> Node:
	while node.get_parent() != null:
		if node.name == "Main":
			return node
		node = node.get_parent()
	return node
