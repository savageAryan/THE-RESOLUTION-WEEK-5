extends Control
@onready var word_nodes = $GridContainer.get_children()

var mixed_words = []
var selected_words = []

func _ready():
	var collected = GameManager.collected_words
	var api_words = GameManager.correct_sentence
	
	mixed_words = collected + api_words
	mixed_words.shuffle()
	
	show_words()
	
func show_words():
	for i in range(min(mixed_words.size(),word_nodes.size())):
		var btn = word_nodes
		btn.text = mixed_words[i]
		
		btn.modulate = Color(1,1,1)
		btn.set_meta("selected", false)
