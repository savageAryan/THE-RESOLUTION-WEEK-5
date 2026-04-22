extends Button


@onready var grid: GridContainer = $"../GridContainer"

@onready var score: Label = $"../score"


func _on_pressed() -> void:
	var selected_words = []
	for child in grid.get_children():
		if child.get_meta("selected", false):
			selected_words.append(child.text)
	var correct = GameManager.collected_words
	var score =0
	
	for word in selected_words:
		if word in correct:
			score += 1
			
			print("score", score)
