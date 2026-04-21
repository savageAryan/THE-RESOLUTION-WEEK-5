extends Control


var mixed_words = []
var selected_words = []

func _ready():
	var collected = GameManager.collected_words
	var api_words = GameManager.correct_sentence
	
	mixed_words = collected + api_words
	mixed_words.shuffle()
	
	#show_words()
