extends Node
@onready var http_request = $WordapiRequester
@onready var player = get_tree().get_first_node_in_group("dinosaur")
@onready var joke_requester: HTTPRequest = $JokeRequester
@onready var joke_label: Label = $dinosaur/JokeLabel

@onready var joke_timer: Timer = $JokeTimer


@onready var label: Label = $Label

var word_nodes = []

var words = []

var api_ready = false



var fallback_words = [
	"GAME", "DEVELOPMENT", "RESOLUTION", "PABLO", "SABOTAGE", "INDIA", "AMERICA", "NINO", "CANNADA", "DAMAGE","EMOTIONAL","BUILDER", "BOB", "KING", "KONG", "MIKU","ITCHIKA", "YOTSUHA", "JERRY"


]

func fetch_joke():
	var url = "https://official-joke-api.appspot.com/random_joke"
	
	joke_requester.request(url)
	


func _ready():
	Worldaudio.play()
	
	
	await get_tree().process_frame
	
	word_nodes = get_tree().get_nodes_in_group("words")
	

	GameManager.collected_words.clear()

	
	if player:
		player.set_physics_process(false)

	fetch_words()


func fetch_words():
	var url = "https://random-words-api.kushcreates.com/api?length=6&words=10"
	http_request.request(url)


func _on_wordapi_requester_request_completed(result, response_code, headers, body):

	if response_code == 200:
		

		var parsed = JSON.parse_string(body.get_string_from_utf8())

		words.clear()


		for item in parsed:
			if item.has("word"):
				words.append(item["word"])
			
				
		
		
		if words.is_empty():
			words = fallback_words.duplicate()

	else:
		words = fallback_words.duplicate()
		
		
	
	words.shuffle()
	words = words.slice(0, 5)

	GameManager.correct_sentence = words.duplicate()

	assign_words()

	api_ready = true

	if player:
		player.set_physics_process(true)

func assign_words():
	

	for i in range(min(words.size(), word_nodes.size())):
		if word_nodes[i] != null:
			word_nodes[i].set_word(words[i])
			
			
			

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("dinosaur"):
		get_tree().change_scene_to_file("res://scenes/end.tscn")
		
		
func get_random_words(source_words,count):
	var temp = source_words.duplicate()
	temp.shuffle()
	return temp.slice(0, count)






	
func _on_joke_timer_timeout():
	fetch_joke()
	





func _on_joke_requester_request_completed(result, response_code, headers, body):
	


	if response_code == 200:

		var parsed = JSON.parse_string(body.get_string_from_utf8())

		print(parsed)

		if parsed != null:
			var joke = str(parsed["setup"]) + "\n" + str(parsed["punchline"])

			joke_label.text = joke

			print("Joke set:", joke)

	else:
		joke_label.text = "No joke available"
