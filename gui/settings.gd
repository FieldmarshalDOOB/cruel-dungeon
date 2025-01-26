extends Control


func _on_return_pressed():
	get_tree().unload_current_scene()
	get_tree().change_scene_to_file("res://gui/main_menu.tscn")


func _on_full_screen_button_down():
	pass


func _on_full_screen_button_up():
	pass # Replace with function body.


func _on_sfx_value_changed(value):
	pass # Replace with function body.


func _on_volume_value_changed(value):
	pass # Replace with function body.
