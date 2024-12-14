extends Node2D
class_name Entity

var GRAVITY := Constants.GRAVITY
var MAX_SPEED := 20
var MAX_FALL := 100
const FRICTION := 5

@export var COLLIDER: Collider

@onready var scaled_position := Vector2i(position) * Constants.SCALE_FACTOR:
	set(value):
		COLLIDER.position = value
		scaled_position = value
		position = scaled_position / Constants.SCALE_FACTOR

var velocity := Vector2i.ZERO:
	set(value):
		COLLIDER.velocity = value
		velocity = value


func _physics_process(delta: float) -> void:
	do_frame()


func do_frame() -> void:
	apply_gravity()
	apply_collision()
	apply_max_speed()
	apply_velocity()


func apply_gravity() -> void:
	velocity += GRAVITY * Vector2i.DOWN


func apply_collision() -> void:
	if velocity.y > 0:
		var platforms := COLLIDER.get_touching_platforms()
		if len(platforms) > 0:
			scaled_position.y = platforms[0].position.y
			velocity.y = 0


func apply_max_speed() -> void:
	velocity.x = clampi(velocity.x, -MAX_SPEED, MAX_SPEED)
	velocity.y = clampi(velocity.y, -MAX_FALL, MAX_FALL)


func apply_velocity() -> void:
	scaled_position += velocity
	position = scaled_position / Constants.SCALE_FACTOR
