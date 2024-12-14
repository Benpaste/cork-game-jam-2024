extends Entity
class_name Player

const WALK_SPEED := 5
const JUMP_SPEED := 20

@export var STATS: PlayerStats


func do_frame() -> void:
	apply_gravity()
	apply_collision()
	take_input()
	apply_max_speed()
	apply_velocity()
	check_pickups()


func take_input() -> void:
	var input_vector := InputManager.get_pressed_vector()
	if input_vector.x == 0:
		apply_friction()
	else:
		velocity.x += WALK_SPEED * input_vector.x
	
	match InputManager.get_just_vector().y:
		-1:
			if is_grounded():
				apply_jump()
		1:
			if is_grounded():
				apply_dropdown()


func apply_friction() -> void:
	velocity.x = move_toward(velocity.x, 0, FRICTION)


func apply_jump() -> void:
	velocity += Vector2i.UP * JUMP_SPEED


func apply_dropdown() -> void:
	scaled_position += Vector2i.DOWN * 2


func is_grounded() -> bool:
	return len(COLLIDER.get_touching_platforms()) > 0


func check_pickups() -> void:
	var pickups := COLLIDER.get_touching_pickups()
	if len(pickups) > 0:
		print("Pickup detected")
		collect_pickup(pickups[0])


func collect_pickup(pickup: Pickup) -> void:
	if pickup is WeaponPickup:
		if STATS.apply_item(pickup.weapon_type):
			pickup.collect()
	if pickup is StatsPickup:
		STATS.apply_stats_pickup(pickup)
		pickup.collect()
