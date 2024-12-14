extends Entity
class_name Player

const WALK_SPEED := 5
const JUMP_SPEED := 20
const TRAMPOLINE_SPEED := 15

@export var STATS: PlayerStats

var current_state := State.IDLE
enum State { IDLE, HURT, SWORD, }


func do_frame() -> void:
	
	apply_gravity()
	apply_collision()
	
	if current_state != State.SWORD:
		apply_animation()
	
	if current_state == State.IDLE:
		take_input()
	elif is_grounded():
		apply_friction()
	
	apply_velocity()
	
	if current_state != State.HURT:
		check_pickups()
		check_hits()
		check_enemies()
	
	check_die()


func take_input() -> void:
	var input_vector := InputManager.get_pressed_vector()
	if input_vector.x == 0:
		apply_friction()
	else:
		velocity.x += WALK_SPEED * input_vector.x
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		facing = sign(input_vector.x)
	
	match InputManager.get_just_vector().y:
		-1:
			if is_grounded():
				apply_jump()
		1:
			if is_grounded():
				apply_dropdown()
	
	if InputManager.just_attack():
		match STATS.item:
			Item.Types.SWORD:
				apply_state_sword()


func apply_friction() -> void:
	velocity.x = move_toward(velocity.x, 0, FRICTION)


func apply_jump() -> void:
	velocity += Vector2i.UP * JUMP_SPEED


func apply_dropdown() -> void:
	scaled_position += Vector2i.DOWN * 2


func check_pickups() -> void:
	var pickups := COLLIDER.get_touching_pickups()
	if len(pickups) > 0:
		collect_pickup(pickups[0])



func check_hits() -> void:
	var hits := COLLIDER.get_enemies_touching_hitbox()
	if len(hits) > 0:
		var enemy := hits[0]
		enemy.apply_hurt()



func check_enemies() -> void:
	var enemies := COLLIDER.get_touching_enemies()
	if len(enemies) > 0:
		var enemy := enemies[0]
		if COLLIDER.check_trampoline(enemy):
			apply_trampoline()
			enemy.apply_hurt()
		else:
			apply_state_hurt()


func apply_trampoline() -> void:
	velocity.y = -TRAMPOLINE_SPEED


func apply_state_hurt() -> void:
	STATS.health -= 1
	current_state = State.HURT
	COLLIDER.destroy_hitbox()
	velocity = Vector2i(-10 * facing, -10)
	await get_tree().create_timer(0.5).timeout
	current_state = State.IDLE


func collect_pickup(pickup: Pickup) -> void:
	if pickup is WeaponPickup:
		if STATS.apply_item(pickup.weapon_type):
			pickup.collect()
	if pickup is StatsPickup:
		STATS.apply_stats_pickup(pickup)
		pickup.collect()


func apply_state_sword() -> void:
	current_state = State.SWORD
	$AnimatedSprite2D.play("sword1")
	await get_tree().create_timer(0.2).timeout
	$AnimatedSprite2D.play("sword2")
	velocity.x = 40 * facing
	COLLIDER.create_hitbox(Rect2i(Vector2i.UP * 70, Vector2i(150 * facing, 40)).abs())
	await get_tree().create_timer(0.5).timeout
	apply_state_idle()


func apply_state_idle() -> void:
	current_state = State.IDLE
	COLLIDER.destroy_hitbox()


func check_die() -> void:
	if scaled_position.y >= Constants.KILL_HEIGHT:
		STATS.lives -= 1
		if STATS.lives <= 0:
			game_over()
		else:
			respawn()


func respawn() -> void:
	apply_state_idle()
	STATS.reset()
	velocity = Vector2i.ZERO
	scaled_position = Vector2i(300, 200) * Constants.SCALE_FACTOR / 2


func game_over() -> void:
	get_tree().change_scene_to_file("res://code/menu/main_menu.tscn")


func apply_animation() -> void:
	if velocity == Vector2i.ZERO:
		$AnimatedSprite2D.play("stand")
	else:
		$AnimatedSprite2D.play("walk")
	$AnimatedSprite2D.flip_h = facing == -1
