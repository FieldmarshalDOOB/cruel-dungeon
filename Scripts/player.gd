extends CharacterBody2D
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword = $Sword

var hp:int  = 10 #Жизни игрока
var hp_regeneration:int = 1 #Реген хп в секунду
var xp:int = 0 #Опыт
var speed:int = 50 #Скорость перса
var target:Vector2 = Vector2(-439,224) #Куда бежит перс в начале
var player_alive:bool = true #Живой?
var attack_range = 12 #Должен быть как радиус хитбокса

func _physics_process(_delta): 
	#update_health()
	if hp <= 0:
		player_alive = false
		hp = 0
		get_tree().change_scene_to_file("res://gui/game_over.tscn")
		queue_free()
	##Заменить всё что ниже на движение к концу уровня
	if Input.is_action_just_pressed("left_click"): #Движение по клику
		target = get_global_mouse_position()
	
	velocity = position.direction_to(target) * speed
	#Если цель близко, то тормозит(чтоб не дрожало)
	if position.distance_to(target) > 5: 
		move_and_slide()
	#Поворт спрайтa
	if position.x == target.x: 
		player_sprite.play("idle")
	elif position.x > target.x:
		player_sprite.flip_h = true
	elif position.x < target.x:
		player_sprite.flip_h = false

#Визуальное обновление хпбара
func update_health():
	var hp_bar = $player_hp_bar
	hp_bar.value = hp
	#Прячет полоску хп если хп фулл
	if hp >= 100: #убрать если в будет худ
		hp_bar.visible = false
	else:
		hp_bar.visible = true

#Реген здоровья по таймеру
func _on_hp_regen_timeout() -> void:
	if hp < 100:
		hp += hp_regeneration
		if hp > 100:
			hp = 100
	if hp <= 0:
		hp = 0


func _on_player_hitbox_body_entered(body):
	var enemies = get_tree().get_nodes_in_group("enemy")
	body = enemies
	enemies = enemies.filter(func(enemy:Node2D):
		return enemy.global_position.distance_squared_to(global_position) < pow(attack_range, 2))
	if enemies.size() == 0:
		return
	enemies.sort_custom(func(a:Node2D, b:Node2D):
		var a_dis = a.global_position.distance_squared_to(global_position)
		var b_dis = b.global_position.distance_squared_to(global_position)
		return a_dis < b_dis)
	$AnimationPlayer.play("attack_animation")
