extends Object

signal body_grow

enum Direction {
	UNKNOWN,
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

var _body: Array
var _direction: int = Direction.RIGHT
var _color: Color
var _grid: Grid

func _init(start: Point, length: int, fill_color: Color, grid: Grid):
	_color = fill_color
	_grid = grid
	# Create the body with the first block at the end.
	for a in range(length - 1, -1, -1):
		_body.append(Point.new(start.i, start.j - a))
	assert(_check_bounds(true), "snake out of bounds: (%d, %d)" % [start.i, start.j])
	_full_draw()

# Move the snake along _direction, returns false if it hit the bounds.
func move(grow: bool = false) -> bool:
	if grow:
		_body.append(Point.new(_body.back().i, _body.back().j))
		emit_signal("body_grow")
	else:
		_clear_end()
		_advance_body()
	match _direction:
		Direction.UP:
			_body.back().i -= 1
		Direction.DOWN:
			_body.back().i += 1
		Direction.LEFT:
			_body.back().j -= 1
		Direction.RIGHT:
			_body.back().j += 1
	if not _check_bounds():
		return false
	_draw_start()
	return true

func get_head() -> Point:
	return _body.back()

func change_direction(new_direction: int):
	match _direction:
		Direction.UP:
			if new_direction in [Direction.LEFT, Direction.RIGHT]:
				_direction = new_direction 
		Direction.DOWN:
			if new_direction in [Direction.LEFT, Direction.RIGHT]:
				_direction = new_direction
		Direction.LEFT:
			if new_direction in [Direction.UP, Direction.DOWN]:
				_direction = new_direction
		Direction.RIGHT:
			if new_direction in [Direction.UP, Direction.DOWN]:
				_direction = new_direction

# Check if the snake is out of bounds.
func _check_bounds(include_front: bool = false) -> bool:
	var front = true
	if include_front:
		front = (_body.front().i >= 0 and _body.front().j >= 0) and (
		_body.front().i < _grid.get_height() and _body.front().j < _grid.get_width())
	return front and (_body.back().i >= 0 and _body.back().j >= 0) and (
		_body.back().i < _grid.get_height() and _body.back().j < _grid.get_width())

# Reclaculate the body points forward.
func _advance_body():
	for i in range(len(_body) - 1):
		_body[i].i = _body[i+1].i
		_body[i].j = _body[i+1].j

func _full_draw():
	for p in _body:
		_grid.paint_square(p, _color)

# Draw the snake on the Grid.
func _draw_start():
	_grid.paint_square(_body.back(), _color)

# Clear the end of the snake.
func _clear_end():
	_grid.clear_square(_body.front())
