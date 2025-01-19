extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#Определяем скорость перса
const SPEED = 100
#Определяем вектор движения
#"move_left"	or	LEFT	= -1,0
#"move_right"	or	RIGHT	= 1,0
#"move_up"		or	UP		= 0,1
#"move_down"	or	DOWN 	= 0=-1
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * SPEED 
	#Поворачиваем спрайт лево-право по х кординате вектора(надо добавить верх-низ)
	if direction.x == 1:
		animated_sprite_2d.flip_h = true
	elif direction.x == -1:
		animated_sprite_2d.flip_h = false

	move_and_slide()
	
	
