extends Button



@onready var score: Label = $"../score"


func _on_pressed() -> void:
	var grid = get_node("GridContainer")
	var word_nodes = grid.get_children()
	var score = 0
	
	for node in word_nodes:
		if node and node.selected:
			if node.word in GameManager.correct_sentence:
				score += 1
				
				score.text = "SCORE- " + str(score)
