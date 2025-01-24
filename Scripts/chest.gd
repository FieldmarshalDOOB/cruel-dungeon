extends StaticBody2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		looting()

func looting():
	pass

func _on_area_2d_body_exited(_body: Node2D) -> void:
	pass # Replace with function body.
