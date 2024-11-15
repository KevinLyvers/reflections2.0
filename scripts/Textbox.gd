extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplay

@onready var goneTimer = $GoneTimer

const MAX_WIDTH = 256 * 4

var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punc_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String):
	text = text_to_display
	label.text = text
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized # need both
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x / 2
	global_position.y -= size.y - 44
	
	label.text = ""
	display_letter()
	
func display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		goneTimer.start()
		
		return
		
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punc_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
			



func _on_letter_display_timeout():
	display_letter()


func _on_gone_timer_timeout():
	self.queue_free()
	pass # Replace with function body.
