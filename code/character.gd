extends Node2D
class_name Character

const WALK_SPEED := 5
const MAX_SPEED := 20
const JUMP_SPEED := 20
const FRICTION := 5

var velocity := Vector2i.ZERO
@onready var COLLIDER: CharacterCollider = $CharacterCollider
@onready var scaled_position := Vector2i(position) * Constants.SCALE_FACTOR:
	set(value):
		COLLIDER.position = value
		scaled_position = value
		position = scaled_position / Constants.SCALE_FACTOR


func _physics_process(delta: float) -> void:
	apply_gravity()
	apply_collision()
	take_input()
	apply_max_speed()
	apply_velocity()


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


func apply_velocity() -> void:
	scaled_position += velocity
	position = scaled_position / Constants.SCALE_FACTOR


func apply_gravity() -> void:
	velocity += Constants.GRAVITY * Vector2i.DOWN


func apply_collision() -> void:
	var platforms := COLLIDER.get_touching_platforms()
	if len(platforms) > 0:
		scaled_position.y = platforms[0].position.y
		velocity.y = 0


func apply_friction() -> void:
	velocity.x = move_toward(velocity.x, 0, FRICTION)


func apply_max_speed() -> void:
	velocity.x = clampi(velocity.x, -MAX_SPEED, MAX_SPEED)


func apply_jump() -> void:
	velocity += Vector2i.UP * JUMP_SPEED


func apply_dropdown() -> void:
	scaled_position += Vector2i.DOWN



func is_grounded() -> bool:
	return len(COLLIDER.get_touching_platforms()) > 0
