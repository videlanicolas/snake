class_name Point

extends Object

var i: int
var j: int

func _init(_i: int, _j: int):
	i = _i
	j = _j

func compare(point: Point) -> bool:
	return point.i == i and point.j == j
