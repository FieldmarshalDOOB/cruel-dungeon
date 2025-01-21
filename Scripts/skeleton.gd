extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var speed = 70 #Чем выше тем медленее - мы делем на скокрость
var player_chaise = false
var player = null
var hp = 100
var player_in_attack_zone = false
var can_take_dmg = true


func _physics_process(_delta: float) -> void:
	deal_with_damage()
	if player_chaise:
		position += (player.position - position)/speed
		animated_sprite_2d.play("walk")
		if (player.position.x - position.x) < 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.play("idle")


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chaise = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chaise = false

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_zone = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_zone = false

func deal_with_damage():
	if player_in_attack_zone and global.player_current_attack == true:
		if can_take_dmg:
			hp -= 20
			$take_damage_cooldown.start()
			can_take_dmg = false
			print("Skeleton HP: " + str(hp))
			if hp <= 0:
				self.queue_free()


func _on_take_damage_cooldown_timeout() -> void:
	can_take_dmg = true
