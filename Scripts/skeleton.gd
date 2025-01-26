extends CharacterBody2D
@onready var skeleton_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_tree().get_first_node_in_group("player") as Node2D
@onready var health_component = $Health_component



var speed = 30
var hp = 100
var player_chaise : bool

func _process(_delta):
	update_health()
	if player_chaise:
		var direction = get_direction_to_player()
		velocity = speed * direction
		move_and_slide()
		skeleton_sprite.play("walk")
		if (player.position.x - position.x) < 0:
			skeleton_sprite.flip_h = true
		else:
			skeleton_sprite.flip_h = false
	else:
		skeleton_sprite.play("idle")


func get_direction_to_player():
	if player != null:
		return (player.global_position - global_position).normalized()
	else:
		return Vector2.ZERO


func update_health():
	var hp_bar = $skeleton_hp_bar
	hp_bar.value = hp
	#Прячет полоску хп если хп фулл
	if hp >= 100:
		hp_bar.visible = false
	else:
		hp_bar.visible = true


func _on_skeleton_detection_area_body_entered(_body):
	_body = player
	player_chaise = true


func _on_skeleton_detection_area_body_exited(_body):
	_body = player
	player_chaise = false


func _on_skeleton_hitbox_body_entered(body):
	body = player
	health_component.take_damage(20)
