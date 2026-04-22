extends Button


@onready var grid: GridContainer = $"../GridContainer"
@onready var scorelabel: Label = $"../scorelabel"

@onready var buttonclick_4: AudioStreamPlayer = $buttonclick4

@onready var label: Label = $"../Label"
@onready var restart: Button = $"../restart"
@onready var label_2: Label = $"../Label2"


@onready var quit: Button = $"../quit"

func _on_pressed() -> void:
	buttonclick_4.play()
	var selected_words = []
	for child in grid.get_children():
		if child.get_meta("selected", false):
			selected_words.append(child.text)
	var correct = GameManager.collected_words
	var score =0
	
	await get_tree().create_timer(1).timeout
	text = "quit"
	grid.visible = false
	scorelabel. visible = true
	label.visible = false
	quit.visible = true
	visible = false
	restart.visible = true
	label_2.visible = false
	

	for word in selected_words:
		if word in correct:
			score += 1
			scorelabel.text = "score: " + str(score)
			
			print("score", score)
			
