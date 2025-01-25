extends CharacterBody2D
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

var hp:int  = 10 #Жизни игрока
var hp_regeneration:int = 1 #Реген хп в секунду
var xp:int = 0 #Опыт
var speed:int = 50 #Скорость перса
var target:Vector2 = Vector2(-439,224) #Куда бежит перс в начале
var player_alive:bool = true #Живой?


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
