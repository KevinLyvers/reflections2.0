extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()

var not_moving = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var my_random_number = rng.randi_range(0, 100)
	
	if my_random_number == 0 and not_moving:
		
		var viewport_size = get_viewport().size
		
		var random_x = rng.randf_range(-200, 0)
		var random_y = rng.randf_range(-100, 100)
		
		# Create a Vector2 for screen position
		position = Vector2(random_x, random_y)
		
		self.visible = true
		not_moving = false
		play("default")
		
func _on_animation_finished():
	not_moving = true
	self.visible = false
