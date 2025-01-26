extends StaticBody2D
@onready var player = $"."
@onready var animation_player = $AnimationPlayer


func _on_chest_loot_zone_body_entered(_body):
	animation_player.play("chest_looting")
