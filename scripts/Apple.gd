extends Object

var position: Point

var _color: Color
var _grid: Grid

func _init(init_position: Point, fill_color: Color, grid: Grid):
	_grid = grid
	_color = fill_color
	position = init_position
	draw()

func clear():
	_grid.clear_square(position)

func draw():
	_grid.paint_square(position, _color, true)
