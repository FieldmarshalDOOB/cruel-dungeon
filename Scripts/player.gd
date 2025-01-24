extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var hp:int  = 100 #Жизни игрока
var hp_regeneration:float = 0.5 #Реген хп в секунду
var xp:int = 0
var speed:int = 50 #Скорость перса

var target:Vector2 = Vector2(-439,224) #Куда бежит перс в начале
var enemy_in_attack_range:bool = false
var enemy_attack_cooldown:bool = true
var player_alive:bool = true
var attack_ip:bool = false


func _physics_process(_delta): 
	enemy_attack()
	attack()
	update_health()
	
	if hp <= 0:
		player_alive = false #ЭКРН СМЕРТИ - МЕНЮ
		hp = 0
		print('player dead')
		self.queue_free()

	if Input.is_action_just_pressed("left_click"): #Движение по клику
		target = get_global_mouse_position()
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 5: #Если цель близко тормозит(чтоб не дрожало)
		move_and_slide()

	if self.position.x == target.x: #Поворт спрайтa
		$AnimatedSprite2D.play("idle")
	elif self.position.x > target.x:
		animated_sprite_2d.flip_h = true
	elif self.position.x < target.x:
		animated_sprite_2d.flip_h = false


func player(): #Определение игрока по функции
	pass


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = false


func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		hp -= 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		#print("Player HP: " + str(hp))


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true

func attack():
	#var dir = Vector2() #Сюда добавить внимации атаки в зависимости от направления
	if enemy_in_attack_range:
		global.player_current_attack = true
		attack_ip = true
		$deal_attack_timer.start()


func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false


func update_health():
	var hpbar = $player_hp_bar
	hpbar.value = hp
	#Прячет полоску хп если хп фулл
	if hp >= 100: #убрать если в будет худ
		hpbar.visible = false
	else:
		hpbar.visible = true


func _on_hp_regen_timeout() -> void:
	if hp < 100:
		hp += hp_regeneration
		if hp > 100:
			hp = 100
	if hp <= 0:
		hp = 0
