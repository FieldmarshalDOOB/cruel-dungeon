extends Node2D

func _input(_event):
	if Input.is_action_pressed("ESC"):
		get_tree().change_scene_to_file("res://gui/esc_menu.tscn")
