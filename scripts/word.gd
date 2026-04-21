
extends Area2D
@onready var dinosaur: CharacterBody2D = $"../dinosaur"

var word = ""
func set_word(w):
	word = w
	$Label.text = word


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("dinosaur"):
		dinosaur.velocity.y + 4
		GameManager.collected_words.append(word)
		print("Collected:",GameManager.collected_words)
		queue_free()
