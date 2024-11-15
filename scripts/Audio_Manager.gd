extends Node

@onready var collide_sfx = get_node("Collide_SFX")
@onready var fall_sfx = $Fall_SFX
@onready var win_sfx = $Win_SFX
@onready var slide_sfx = $Slide_SFX

func slide_sfx_play():
	if slide_sfx.playing == false:
		slide_sfx.play()
	#
#func _process(delta):
	#if collide_sfx != null:
		#print(collide_sfx)
		#collide_sfx.play()
