extends StaticBody2D
@onready var player = $"."
@onready var animation_player = $AnimationPlayer

var exp = 5
func _on_chest_loot_zone_body_entered(_body):
	Global.exp_bot_collected.emit(exp)
	animation_player.play("chest_looting")
