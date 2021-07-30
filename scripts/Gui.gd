extends MarginContainer

func increment_score():
	$VBoxContainer/Score.text = str(int($VBoxContainer/Score.text) + 1)

func _on_MarginContainer_pause(paused: bool = false):
	$CenterContainer/PauseLabel.visible = paused

func _on_MarginContainer_game_over():
	$CenterContainer/GameOver.visible = true
