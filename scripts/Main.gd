extends MarginContainer

const Apple = preload("res://scripts/Apple.gd")
const Snake = preload("res://scripts/Snake.gd")

export(int) var snake_start_length = 3
export(Color) var snake_body_color = Color.brown
export(Color) var apple_color = Color.red

var _apple: Apple
var _snake: Snake
var _next_move: int = Snake.Direction.UNKNOWN

func _ready():
	randomize()
	_snake = Snake.new(
		Point.new(int($Grid.get_height() / 2), int($Grid.get_width() / 2)),
		snake_start_length, 
		snake_body_color, 
		$Grid)
	_snake.connect("body_grow", $SnakeMovementTimer, "increment_timer")
	_apple = Apple.new(
		_get_random_empty_grid_point(),
		apple_color,
		$Grid)

func _input(event):
	if _next_move != Snake.Direction.UNKNOWN:
		return
	if event.is_action_pressed("ui_up"):
		_next_move = Snake.Direction.UP
	elif event.is_action_pressed("ui_down"):
		_next_move = Snake.Direction.DOWN
	elif event.is_action_pressed("ui_left"):
		_next_move = Snake.Direction.LEFT
	elif event.is_action_pressed("ui_right"):
		_next_move = Snake.Direction.RIGHT

func _on_SnakeMovementTimer_timeout():
	var grow: bool = false
	if _snake.get_head().compare(_apple.position):
		grow = true
		var new_apple_position: Point = _get_random_empty_grid_point()
		_apple.position = new_apple_position
		_apple.draw()
	if _next_move != Snake.Direction.UNKNOWN:
		_snake.change_direction(_next_move)
		_next_move = Snake.Direction.UNKNOWN
	if not _snake.move(grow):
		print("Game over.")

func _get_random_empty_grid_point() -> Point:
	var empty_nodes: Array = get_tree().get_nodes_in_group(Grid.EMPTY)
	return empty_nodes[randi() % len(empty_nodes)].get_point()
