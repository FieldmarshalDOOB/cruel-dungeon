extends Control


func _on_return_pressed() -> void:
	pass


func _on_settigns_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/settings.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/main_menu.tscn")
