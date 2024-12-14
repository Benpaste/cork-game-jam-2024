extends Node2D


func _physics_process(delta: float) -> void:
	if InputManager.just_attack():
		get_tree().change_scene_to_file("res://code/main.tscn")
