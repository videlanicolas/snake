extends MarginContainer

const Snake = preload("res://scripts/Snake.gd")

export(int) var snake_start_length = 3
export(Color) var snake_body_color = Color.brown

var _snake: Snake

func _ready():
	_snake = Snake.new(
		Point.new(int($Grid.get_height() / 2), int($Grid.get_width() / 2)),
		snake_start_length, 
		snake_body_color, 
		$Grid)

func _input(event):
	if event.is_action_pressed("ui_up"):
		_snake.change_direction(Snake.Direction.UP)
	elif event.is_action_pressed("ui_down"):
		_snake.change_direction(Snake.Direction.DOWN)
	elif event.is_action_pressed("ui_left"):
		_snake.change_direction(Snake.Direction.LEFT)
	elif event.is_action_pressed("ui_right"):
		_snake.change_direction(Snake.Direction.RIGHT)

func _on_SnakeMovementTimer_timeout():
	if not _snake.move():
		print("Game over.")
	print("i: %d, j: %d" % [_snake.get_head().i, _snake.get_head().j])