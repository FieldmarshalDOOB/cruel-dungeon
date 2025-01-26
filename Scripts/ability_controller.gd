extends Node

@export var spawn_ability: PackedScene

@onready var player_hitbox = $"../../player_hitbox"
@onready var player = get_tree().get_first_node_in_group("player") as Node2D

var spawn_point:Vector2
var cooldown:bool


#func _input(_event):
	#if Input.is_action_just_pressed("right_click") == true and cooldown == false:
		#spawn_point = player.global_position 
		#if player == null:
			#return
		#var ability_instance = spawn_ability.instantiate() as Node2D
		#player.get_parent().add_child(ability_instance)
		#ability_instance.global_position = player.global_position
		#cooldown = true
		#$Cooldown.start()

func _on_timer_timeout():
	cooldown = false
