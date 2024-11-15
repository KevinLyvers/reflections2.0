extends Node

@onready var tier1_mus = $Tier1
@onready var tier2_mus = $Tier2
@onready var tier3_mus = $Tier3
@onready var tier4_mus = $Tier4
@onready var tier5_mus = $Tier5
@onready var tier6_mus = $Tier6
@onready var tier7_mus = $Tier7
@onready var tier8_mus = $Tier8
@onready var tier9_mus = $Tier9
@onready var tier10_mus = $Tier10

@onready var hardwind = $HardWind
@onready var lightwind = $LightWind

@onready var tiers_mus = [tier1_mus, tier2_mus, tier3_mus, tier4_mus, tier5_mus, tier6_mus, tier7_mus, tier8_mus, tier9_mus, tier10_mus, ]

@onready var voice_overs = []

var first = true

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in tiers_mus:
		i.volume_db = -80
		i.play()
	
	hardwind.volume_db = -80
	hardwind.play()
	
	lightwind.volume_db = -80
	lightwind.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_lightwind():
	while lightwind.volume_db < -10:
		lightwind.volume_db += 1.0

func create_hardwind():
	while hardwind.volume_db < -10:
		hardwind.volume_db += 0.5

#layer comes from the level audio layer
func fade_in_audio(fade_in_duration: float, layer: int):
	if layer == 1:
		create_lightwind()
	
	if layer == 2:
		create_hardwind()
	
	while tiers_mus[layer].volume_db < -10:
		tiers_mus[layer].volume_db += 1.0

func play_voiceover_audio(line_num: int):
	if line_num == -1:
		return 
	voice_overs[line_num].play()
