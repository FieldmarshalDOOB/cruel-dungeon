extends Node2D

func _input(event):
	if Input.is_action_pressed("ESC"):
		get_tree().change_scene_to_file("esc_menu")
