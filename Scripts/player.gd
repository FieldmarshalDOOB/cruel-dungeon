extends CharacterBody2D
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d : NavigationAgent2D = $NavigationAgent2D
@onready var end_target : Area2D = $"../end_target"

@export var target: Node2D = end_target

var hp: int  = 10 #Жизни игрока
var hp_regen: int = 1 #Реген хп в секунду
var mana: int = 100 #Maнa
var mana_regen: int = 1 #Реген маны в секунду
var xp: int = 0 #Опыт
var speed: int = 50 #Скорость перса
var player_alive: bool = true #Живой?
var attack_range: int = 12 #Должен быть как радиус хитбокса


func _physics_process(_delta):
	await get_tree().physics_frame 
	update_health()
	if hp <= 0:
		player_alive = false
		hp = 0
		player_sprite.play("death")
		get_tree().change_scene_to_file("res://gui/game_over.tscn")
		get_tree().queue_free()
		
	if is_instance_valid(target):#Движение через агента
		navigation_agent_2d.target_position = target.global_position
	if navigation_agent_2d.is_navigation_finished():
		#navigation_agent_2d.target_position = end_target.global_position
		acquire_target()
		pass

	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * speed
	player_sprite.flip_h = false if velocity.x > 0 else true
	move_and_slide()
	
	#if position.x > target.x:#Поворт спрайтa
		#player_sprite.flip_h = true
	#elif position.x < target.x:
		#player_sprite.flip_h = false


func _ready():
	call_deferred("seeker_setup")


func seeker_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position


func acquire_target():
	if !is_instance_valid(target):
		target = end_target


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

func _on_player_vision_body_entered(body):
	if body == get_tree().get_first_node_in_group("chest"):
		target = body
	if body == get_tree().get_first_node_in_group("enemy"):
		target = body
