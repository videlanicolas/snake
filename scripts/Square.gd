extends ColorRect

const TRANSPARENT = Color(0, 0, 0, 0)

func clear():
	self.color = TRANSPARENT

func is_filled():
	return self.color != TRANSPARENT
