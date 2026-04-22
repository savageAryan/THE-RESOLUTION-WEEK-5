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
		modulate = Color(1, 1, 1)
		set_meta("selected", false)
		
	else:
		modulate = Color(0.5, 1, 0.5)
		set_meta("selected", true)
		
		
