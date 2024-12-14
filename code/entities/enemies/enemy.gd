extends Entity
class_name Enemy


func do_frame():
	if is_grounded():
		velocity.x = 5 * facing
		$AnimatedSprite2D.flip_h = (facing == 1)
	else:
		velocity.x = 0
	super.do_frame()


func apply_hurt() -> void:
	active = false
	queue_free()
