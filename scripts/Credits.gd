extends TextureButton

func _on_Credits_pressed():
	get_node("/root/MarginContainer/CenterContainer/AcceptDialog").popup()
