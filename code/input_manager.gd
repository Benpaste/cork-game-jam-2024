extends Node
class_name InputManager


const DIRECTIONS := {
	"ui_left":	Vector2i.LEFT,
	"ui_right":	Vector2i.RIGHT,
	"ui_down":	Vector2i.DOWN,
	"ui_up":	Vector2i.UP,
}


static func get_pressed_vector() -> Vector2i:
	return get_vector(Input.is_action_pressed)


static func get_just_vector() -> Vector2i:
	return get_vector(Input.is_action_just_pressed)


static func get_vector(callable: Callable) -> Vector2i:
	var out := Vector2i.ZERO
	for action: String in DIRECTIONS.keys():
		if callable.call(action):
			out += DIRECTIONS[action]
	return out


static func just_attack() -> bool:
	return Input.is_action_just_pressed("ui_accept")
