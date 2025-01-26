extends CharacterBody2D
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

var hp:int  = 10 #Жизни игрока
var hp_regen:int = 1 #Реген хп в секунду
var mana = 100 #Maнa
var mana_regen:int = 1 #Реген маны в секунду
var xp:int = 0 #Опыт
var speed:int = 50 #Скорость перса
var target:Vector2 = Vector2(-439,224) #Куда бежит перс в начале
var player_alive:bool = true #Живой?
var attack_range = 12 #Должен быть как радиус хитбокса
var acceleration = .30

func _physics_process(_delta): 
	#update_health()
	if hp <= 0:
		player_alive = false
		hp = 0
		player_sprite.play("death")
		get_tree().change_scene_to_file("res://gui/game_over.tscn")
		queue_free()
	##Заменить всё что ниже на движение к концу уровня
	if Input.is_action_just_pressed("left_click"): #Движение по клику
		player_sprite.play("walk")
		target = get_global_mouse_position()
	#var target_velocity = speed * acceleration
	#velocity = position.direction_to(target) * speed
	var target_velocity = position.direction_to(target) * speed
	velocity = velocity.lerp(target_velocity, acceleration)
	#Если цель близко, то тормозит(чтоб не дрожало)
	if position.distance_to(target) > 5: 
		move_and_slide()
	#Поворт спрайтa
	if position == target: 
		player_sprite.play("idle")#Неработаит
	elif position.x > target.x:
		player_sprite.flip_h = true
	elif position.x < target.x:
		player_sprite.flip_h = false


func attack():
	var enemies = get_tree().get_nodes_in_group("enemy")#Определяет врага по группе враг
	enemies = enemies.filter(func(enemy:Node2D):
		#Создает масив врагов из тех кто находится в зоне актаки
		return enemy.global_position.distance_squared_to(global_position) < pow(attack_range, 2))
	if enemies.size() == 0:#Если масив пустой ничего не делает
		return
	enemies.sort_custom(func(a:Node2D, b:Node2D):#Если не пустой сортирует по близости к игроку
		var a_dis = a.global_position.distance_squared_to(global_position)
		var b_dis = b.global_position.distance_squared_to(global_position)
		return a_dis < b_dis)
	player_sprite.play("attack")


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
		hp += hp_regen
		player_sprite.play("cast")
		if hp > 100:
			hp = 100
	if hp <= 0:
		hp = 0


func _on_player_hitbox_body_entered(body):
	var enemy = get_tree().get_first_node_in_group("enemy") as Node2D
	if body == enemy:
		attack()
#player_sprite.play("take_dmg")
