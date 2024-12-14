extends Node2D
class_name EnemySpawner

@export var facing := 1
@export var enemy_scene: PackedScene


func _on_timer_timeout() -> void:
	var new_enemy: Enemy = enemy_scene.instantiate()
	new_enemy.facing = facing
	new_enemy.scaled_position = position * Constants.SCALE_FACTOR
	get_parent().add_child(new_enemy)
