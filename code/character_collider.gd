extends Node2D
class_name CharacterCollider

const SIZE := 8
const COLLISION_COLOR := Color.YELLOW


func _process(delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	draw_rect(Constants.shift_rect(get_collision_rect(), -position), COLLISION_COLOR)


func get_platform_collision_rects() -> Array[Rect2i]:
	var out: Array[Rect2i]
	for platform: Platform in get_tree().get_nodes_in_group("platforms"):
		out.append(platform.get_global_collision_rect())
	return out


func get_collision_rect() -> Rect2i:
	return Rect2i(Vector2i.ONE * -SIZE / 2, Vector2i.ONE * SIZE)


func get_global_collision_rect() -> Rect2i:
	return Constants.shift_rect(get_collision_rect(), position)


func get_touching_platforms() -> Array[Rect2i]:
	var out: Array[Rect2i] = []
	var my_rect := get_global_collision_rect()
	for rect in get_platform_collision_rects():
		if rect.intersects(my_rect):
			out.append(rect)
	return out
