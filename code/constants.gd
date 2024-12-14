extends Node
class_name Constants

const GRAVITY := 1
const SCALE_FACTOR := 10


static func shrink_rect(rect: Rect2i) -> Rect2i:
	return Rect2i(rect.position / SCALE_FACTOR, rect.size / SCALE_FACTOR)


static func grow_rect(rect: Rect2i) -> Rect2i:
	return Rect2i(rect.position * SCALE_FACTOR, rect.size * SCALE_FACTOR)


static func shift_rect(rect: Rect2i, shift: Vector2i) -> Rect2i:
	return Rect2i(rect.position + shift, rect.size)
