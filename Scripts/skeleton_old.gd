extends CharacterBody2D
@onready var skeleton_sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed = 70 #Чем выше тем медленее - мы делем на скокрость
var player_chaise = false
var player = null
var hp = 100
var player_in_attack_zone = false
var can_take_dmg = true
var hp_regeneration = 0

func _physics_process(_delta: float) -> void:
	deal_with_damage()
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


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chaise = true


func _on_detection_area_body_exited(_body: Node2D) -> void:
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
	#if player_in_attack_zone and global.player_current_attack == true:
		if can_take_dmg:
			hp -= 20
			$AnimatedSprite2D.play("hit")
			$take_damage_cooldown.start()
			can_take_dmg = false
			#print("Skeleton HP: " + str(hp))
			if hp <= 0:
				$AnimatedSprite2D.play("death")
				self.queue_free()


func update_health():
	var hpbar = $skeleton_hp_bar
	hpbar.value = hp
	#Прячет полоску хп если хп фулл
	if hp >= 100: #убрать если в будет худ
		hpbar.visible = false
	else:
		hpbar.visible = true


func _on_take_damage_cooldown_timeout() -> void:
	can_take_dmg = true


func _on_hp_regen_timeout() -> void:
	if hp < 100:
		hp += hp_regeneration
		if hp > 100:
			hp = 100
	if hp <= 0:
		hp = 0
