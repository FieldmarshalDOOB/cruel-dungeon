extends CharacterBody2D
@onready var skeleton_sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed = 70 #Чем выше тем медленее - мы делем на скокрость
var player_chaise = false
var hp = 100
var player = get_tree().get_first_node_in_group("player") as Node2D

func _physics_process(_delta: float) -> void:
	update_health()
	
	if player_chaise:
		position += (player.position - position)/speed
		skeleton_sprite.play("walk")
		if (player.position.x - position.x) < 0:
			skeleton_sprite.flip_h = true
		else:
			skeleton_sprite.flip_h = false
	else:
		skeleton_sprite.play("idle")


func update_health():
	var hp_bar = $skeleton_hp_bar
	hp_bar.value = hp
	#Прячет полоску хп если хп фулл
	if hp >= 100:
		hp_bar.visible = false
	else:
		hp_bar.visible = true


func _on_detection_area_body_entered(body: Node2D):
	player = body
	player_chaise = true


func _on_detection_area_body_exited(_body: Node2D):
	player = null
	player_chaise = false


func _on_enemy_hitbox_body_entered(body: Node2D):
	if body == player:
		pass


func _on_enemy_hitbox_body_exited(body: Node2D):
	if body == player:
		pass
