@tool
extends Node2D
class_name Platform


const COLLISION_SNAP := 1#50

@export var length := 10
var rect_color := Color.WHITE
var collision_color := Color.RED


func _draw() -> void:
	draw_rect(get_draw_rect(), rect_color)
	if !Constants.DEBUG: return
	draw_rect(Constants.shrink_rect(get_local_collision_rect()), collision_color)
	


func _process(delta: float) -> void:
	queue_redraw()


func get_draw_rect() -> Rect2i:
	return Rect2i(Vector2i.ZERO, Vector2i(length / Constants.SCALE_FACTOR, 1))


func get_local_collision_rect() -> Rect2i:
	return Rect2i(Vector2i.ZERO, get_global_collision_rect().size)


func get_global_collision_rect() -> Rect2i:
	return Rect2i(position * Constants.SCALE_FACTOR, Vector2i(length, COLLISION_SNAP))
