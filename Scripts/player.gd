extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"."

#Определяем скорость перса
var speed = 50
var click_position = Vector2()
var target_position = Vector2()

func _ready() -> void:
	click_position = position
#Определяем вектор движения
#"move_left"	or	LEFT	= -1,0
#"move_right"	or	RIGHT	= 1,0
#"move_up"		or	UP		= 0,1
#"move_down"	or	DOWN 	= 0=-1
func _physics_process(delta: float) -> void:
	#Движение стрелками
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * speed
	#добавить верх-низ
	if direction.x == 1:
		animated_sprite_2d.flip_h = true #Поворачиваем спрайт влево по х кординате вектора
	elif direction.x == -1:
		animated_sprite_2d.flip_h = false #Поворачиваем спрайт вправо по х кординате вектора
	move_and_slide()
	
	
	###Движение кликом
	#if Input.is_action_just_pressed("left_click"):
		#click_position = get_global_mouse_position()
		#
	#if position.distance_to(click_position) > 3:
		#target_position = (click_position - position).normalized()
		#velocity = target_position * speed
		#if position.distance_to(click_position) == position.distance_to(target_position):
			#velocity = target_position * 0
	#look_at(click_position)
	#move_and_slide()
