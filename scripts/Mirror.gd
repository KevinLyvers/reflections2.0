extends Node2D

var fell = false

var penguins = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in self.get_children():
		if child.name != "Audio_Manager":
			var dupped_child = child.duplicate()
			self.add_child(dupped_child)
			dupped_child.modulate = Color(0.35, 0.35, .6)
			dupped_child.scale.x *= -1
			
			if child is Sprite2D:
				penguins.append(child)
			
			if dupped_child is Sprite2D:
				penguins.append(dupped_child)
				dupped_child.position.x *= -1
				#dupped_child.position.x -= 32

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fell == true:
		for i in penguins:
			i.position = i.spawn_coords
			i.char_state = "idle"
			i.anmi_state = "off"
			i.animation_player.play("Idle")
			i.set_rotation_degrees(0)
		fell = false
		pass
	

