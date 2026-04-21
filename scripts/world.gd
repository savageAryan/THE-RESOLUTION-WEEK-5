extends Node

@onready var word_nodes = get_tree().get_nodes_in_group("words")

@onready var http_request = $WordapiRequester
var words = []

func _ready():
	fetch_words()

func fetch_words():
	var url = "https://random-word-api.herokuapp.com/word?number=5"  
	http_request.request(url)





func _on_wordapi_requester_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		words = JSON.parse_string(body.get_string_from_utf8())
		print(words)
		
		
		GameManager.correct_sentence = words.duplicate()
		assign_words()

		
func assign_words():
	
	for i in range(min(words.size(), word_nodes.size())):
		if word_nodes[i] != null:
			word_nodes[i].set_word(words[i])
