class_name Grid

extends GridContainer

const Square = preload("res://scenes/Square.tscn")

export(int) var square_size = 40

var _width: int
var _height: int
var _grid_matrix: Array = Array()

func _ready():
	# Create the basic grid.
	_create_grid()
	# Clear the grid.
	clear()

func paint_square(point: Point, fill_color: Color):
	assert(
		point.i >= 0 and point.i < _height and point.j >= 0 and point.j <= _width, 
		"value out of range: i = %d, j = %d" % [point.i, point.j])
	_grid_matrix[point.i][point.j].color = fill_color

func clear_square(point: Point):
	assert(
		point.i >= 0 and point.i < _height and point.j >= 0 and point.j < _width, 
		"value out of range: i = %d, j = %d" % [point.i, point.j])
	_grid_matrix[point.i][point.j].clear()

func clear():
	for a in _grid_matrix:
		for n in a:
			n.clear()

func get_width():
	return _width

func get_height():
	return _height

func _create_grid():
	_width = int(self.rect_size.x / square_size)
	_height = int(self.rect_size.y / square_size)
	print("Grid size: %d x %d" % [_width, _height])
	
	self.columns = _width
	for _i in range(_height):
		var tmp_array = Array()
		for _j in range(_width):
			var inst = Square.instance()
			add_child(inst)
			tmp_array.append(inst)
		_grid_matrix.append(tmp_array)

func _test():
	for a in _grid_matrix:
		for p in a:
			paint_square(p, Color.brown)
