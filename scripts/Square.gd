extends ColorRect

const TRANSPARENT = Color(0, 0, 0, 0)

export(int) var i
export(int) var j

func clear():
	self.color = TRANSPARENT

func is_filled():
	return self.color != TRANSPARENT

func get_point() -> Point:
	return Point.new(i, j)
