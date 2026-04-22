extends Node
@onready var http_request = $WordapiRequester
@onready var player = get_tree().get_first_node_in_group("dinosaur")

var word_nodes = []

var words = []

var api_ready = false



var fallback_words = [
	"GAME", "DEVELOPMENT", "RESOLUTION", "PABLO", "SABOTAGE", "INDIA", "AMERICA", "NINO", "CANNADA", "DAMAGE","EMOTIONAL","BUILDER", "BOB", "KING", "KONG", "MIKU","ITCHIKA", "YOTSUHA", "JERRY"


]




func _ready():
	await get_tree().process_frame
	
	word_nodes = get_tree().get_nodes_in_group("words")
	print("Word nodes found:", word_nodes.size())

	GameManager.collected_words.clear()

	
	if player:
		player.set_physics_process(false)

	fetch_words()


func fetch_words():
	var url = "https://random-word-api.vercel.app/api?words=5"
	http_request.request(url)


func _on_wordapi_requester_request_completed(result, response_code, headers, body):
	print("API called")
	print("Response:", response_code)

	if response_code == 200:
		var parsed = JSON.parse_string(body.get_string_from_utf8())

		if typeof(parsed) == TYPE_ARRAY and parsed.size() > 0:
			words = get_random_words(words, 5)
			
		else:
			
			words = get_random_words(fallback_words, 5)
	else:
		
		words = get_random_words(fallback_words, 5)

	
	GameManager.correct_sentence = words.duplicate()

	assign_words()

	api_ready = true

	
	if player:
		player.set_physics_process(true)


func assign_words():
	print("Assigning words...")

	for i in range(min(words.size(), word_nodes.size())):
		if word_nodes[i] != null:
			word_nodes[i].set_word(words[i])
			
			
			print("Assigned:", words[i])


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("dinosaur"):
		get_tree().change_scene_to_file("res://scenes/end.tscn")
		
		
func get_random_words(source_words,count):
	var temp = source_words.duplicate()
	temp.shuffle()
	return temp.slice(0, count)
