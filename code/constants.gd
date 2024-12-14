extends Node
class_name Constants

const GRAVITY := 1
const SCALE_FACTOR := 10
const DEBUG := true


static func shrink_rect(rect: Rect2i) -> Rect2i:
	var out := Rect2i(rect.position / SCALE_FACTOR, rect.size / SCALE_FACTOR)
	if out.size.x == 0:
		out.size.x = 1
	if out.size.y == 0:
		out.size.y = 1
	return out


static func grow_rect(rect: Rect2i) -> Rect2i:
	return Rect2i(rect.position * SCALE_FACTOR, rect.size * SCALE_FACTOR)


static func shift_rect(rect: Rect2i, shift: Vector2i) -> Rect2i:
	return Rect2i(rect.position + shift, rect.size)



static func adjust_rect_for_velocity(rect: Rect2i, velocity: Vector2i) -> Rect2i:
	if velocity.x < 0:
		rect = rect.grow_individual(velocity.x, 0, 0, 0)
	if velocity.x > 0:
		rect = rect.grow_individual(0, 0, velocity.x, 0)
	if velocity.y < 0:
		rect = rect.grow_individual(0, velocity.y, 0, 0)
	if velocity.y > 0:
		rect = rect.grow_individual(0, 0, 0, velocity.y)
	return rect
