extends Entity
class_name Pickup


func _ready() -> void:
	MAX_FALL = 5


func collect() -> void:
	queue_free()
