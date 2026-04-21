extends Button
var colour

var word = ""
var selected = false
func set_word(w):
	word = w
	text = w
	
	
	
func _pressed() -> void:
	var selected = get_meta("selected", false)
	
	if selected:
		modulate = Color(0, 1, 0)
	else:
		modulate = Color(1, 1, 1)
		
		
