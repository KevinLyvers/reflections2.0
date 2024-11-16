extends Sprite2D

const TILE_SIZE = 32
const MOVE_DURATION = 0.1

@export var won = false

@onready var AudioManager = $Audio_Manager

const lines: Array[String] = [
	"Here we see a group of penguins. They stick together. But then he leaves and the journeh begins"
]

var char_state = "idle"
var anmi_state = "off"
var first = true
var spawn_coords = Vector2(0,0)

enum TILE_TYPES {
	ICE = 0,
	SNOW = 1,
	BLOCK = 2,
	HOLE = 3
}

var TILE_TTYPES_LIST = ["SNOW", "ICE", "BLOCK", "HOLE"]

@export var tilemap_path : NodePath


@onready var animation_player = $AnimationPlayer 
var tilemap

var direction = Vector2(0,0)
var bottom = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	tilemap = find_tilemap()
	animation_player.play("Idle")	
	bottom = $"../../Camera2D".get_viewport_rect().size / 2

func find_tilemap():
	var parent_node = self.get_parent()  # Get the parent of the current node
	var other_tilemap = null
	if parent_node:
		for child in parent_node.get_children():
			if child is TileMap:
				if child.name != "TileMap":
					other_tilemap = child
				if self.name == "Penguin" and child.name == "TileMap":
					return child

		return other_tilemap



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	 #var topLeft = get_camera_screen_center() - get_viewport_rect().size / 2  	
	if first:
		#TextManager.start_dialog(Vector2(0,0.80 * bottom.y), lines)
		spawn_coords = global_position
		first = false
	
	if char_state != "slip":
		AudioManager.slide_sfx.playing = false
	
	if char_state == "win":
		return
	
	if anmi_state == "on":
		return 
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	
	var target = global_position
	
	if char_state == "idle":
		if Input.is_action_just_pressed("ui_right"):
			direction = Vector2(1,0)
		elif Input.is_action_just_pressed("ui_left"):
			direction = Vector2(-1,0)
		elif Input.is_action_just_pressed("ui_up"):
			direction = Vector2(0,-1)
		elif Input.is_action_just_pressed("ui_down"):
			direction = Vector2(0,1)
		direction *= TILE_SIZE
	
	target += direction
	
	if global_position != target:
		move_to_omni(target)

		
func move_to_omni(target_position):
	var curr_tile = get_tile(position)
	var next_tile = get_tile(target_position)
	
	var direction_vector = (target_position - position)
	direction_vector = direction_vector.normalized()
		
	
	#print("Current, ", TILE_TTYPES_LIST[curr_tile])
	#print("Next, ", TILE_TTYPES_LIST[next_tile])
	#print("Difference, ", direction_vector)
	
	var move_state = Vector2(curr_tile, next_tile)
	
	# ["SNOW", "ICE", "BLOCK", "HOLE"]
	if move_state == Vector2(0,0):
		move_to(target_position)
		direction = Vector2(0,0)
		char_state = "idle"
	elif move_state == Vector2(0,1):
		move_to(target_position)
		char_state = "slip"
		AudioManager.slide_sfx_play()
	elif move_state == Vector2(0,2):
		direction = Vector2(0,0)
		char_state = "idle"
	elif move_state == Vector2(0,3):
		move_to(target_position)
		direction = Vector2(0,0)
		char_state = "fall"
		AudioManager.fall_sfx.play()
	elif move_state == Vector2(0,4):
		move_to(target_position)
		direction = Vector2(0,0)
		char_state = "win"
		AudioManager.win_sfx.play()
		
	# ["SNOW", "ICE", "BLOCK", "HOLE"]
	elif move_state == Vector2(1,0):
		move_to(target_position)
		direction = Vector2(0,0)
		char_state = "idle"
	elif move_state == Vector2(1,1):
		move_to(target_position)
		char_state = "slip"
		AudioManager.slide_sfx_play()
	elif move_state == Vector2(1,2):
		if char_state == "slip":
			AudioManager.collide_sfx.play()
		char_state = "idle"
		direction = Vector2(0,0)
	elif move_state == Vector2(1,3):
		move_to(target_position)
		direction = Vector2(0,0)
		char_state = "fall"
		AudioManager.fall_sfx.play()
	elif move_state == Vector2(1,4):
		move_to(target_position)
		direction = Vector2(0,0)
		char_state = "win"
		AudioManager.win_sfx.play()
		
	# ["SNOW", "ICE", "BLOCK", "HOLE"]
	if move_state == Vector2(2,0):
		print("oh no")
	if move_state == Vector2(2,1):
		print("oh no")
	if move_state == Vector2(2,2):
		print("oh no")
	if move_state == Vector2(2,3):
		print("oh no")
	if move_state == Vector2(0,4):
		print("oh no")
		
	# ["SNOW", "ICE", "BLOCK", "HOLE"]
	if move_state == Vector2(3,0):
		print("you loose")
	if move_state == Vector2(3,1):
		print("you loose")
	if move_state == Vector2(3,2):
		print("you loose")
	if move_state == Vector2(3,3):
		print("you loose")
	if move_state == Vector2(0,4):
		print("you loose")
		
	animation_manager(direction_vector)
	
func animation_manager(direction):
	#direction_vector
	#print(char_state)
	if char_state == "idle":
		animation_player.play("Idle")
		
	if char_state == "win":
		animation_player.play("Win")
		
	if char_state == "fall":
		#print("HIT")
		animation_player.play("Fall")
	
	if char_state == "slip":
		if direction == Vector2(1,0):
			animation_player.play("Right")
		if direction == Vector2(-1,0):
			animation_player.play("Left")
		if direction == Vector2(0,-1):
			animation_player.play("Up")
		if direction == Vector2(0,1):
			animation_player.play("Down")
		
func move_to(target_position):
	anmi_state = "on"
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, MOVE_DURATION)
	tween.connect("finished", move_to_finished)

func move_to_finished():	
	anmi_state = "off"

func get_tile(in_position):
	var tile_coords = tilemap.local_to_map(tilemap.to_local(in_position))
	var data = tilemap.get_cell_tile_data(0, tile_coords)
	if data:
		return data.get_custom_data("type")
	return -1


func _on_animation_player_animation_finished(anim_name):
	#print(anim_name)
	if anim_name == "Fall":
		#position = spawn_coords
		set_rotation_degrees(0)
		$"..".fell = true
		
		#char_state = "idle"
		#anmi_state = "off"
		##var _reload = $"..".reload_current_scene()
	
	if anim_name == "Win":
		self.won = true
		
