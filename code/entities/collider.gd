extends Node2D
class_name Collider

const SIZE := 100
const COLLISION_COLOR := Color.YELLOW
const HURTBOX_COLOR := Color.REBECCA_PURPLE
var velocity := Vector2i.ZERO


func _process(delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	if !Constants.DEBUG: return
	draw_rect(Constants.shift_rect(Constants.shrink_rect(get_hurtbox()), -position), HURTBOX_COLOR)
	draw_rect(Constants.shift_rect(Constants.shrink_rect(get_collision_rect()), -position), COLLISION_COLOR)


func get_platform_collision_rects() -> Array[Rect2i]:
	var out: Array[Rect2i]
	for platform: Platform in get_tree().get_nodes_in_group("platforms"):
		out.append(platform.get_global_collision_rect())
	return out


func get_collision_rect() -> Rect2i:
	return Rect2i(Vector2i(-SIZE / 2, 0), Vector2i(SIZE, 1))


func get_global_collision_rect() -> Rect2i:
	return Constants.shift_rect(get_collision_rect(), position)



func get_touching_platforms() -> Array[Rect2i]:
	var out: Array[Rect2i] = []
	var my_rect := Constants.adjust_rect_for_velocity(get_global_collision_rect(), velocity)
	for rect in get_platform_collision_rects():
		if rect.intersects(my_rect):
			out.append(rect)
	return out


func get_hurtbox() -> Rect2i:
	return Rect2i(Vector2i(-SIZE / 2, -SIZE), Vector2i.ONE * SIZE)


func get_global_hurtbox() -> Rect2i:
	return Constants.shift_rect(get_hurtbox(), position)


func get_pickups() -> Array[Pickup]:
	var out: Array[Pickup] = []
	for node in get_tree().get_nodes_in_group("pickups"):
		if node is Pickup:
			out.append(node)
	return out


func get_touching_pickups() -> Array[Pickup]:
	var out: Array[Pickup] = []
	var my_hurtbox := get_global_hurtbox()
	for pickup: Pickup in get_pickups():
		if pickup.COLLIDER.get_global_hurtbox().intersects(my_hurtbox):
			out.append(pickup)
	return out
