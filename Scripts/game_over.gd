extends Control



func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/main_menu.tscn")
