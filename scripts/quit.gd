extends Button
@onready var buttonclick: AudioStreamPlayer = $buttonclick




func _on_pressed() -> void:
	buttonclick.play()
	await get_tree().create_timer(1).timeout
	get_tree().quit()
