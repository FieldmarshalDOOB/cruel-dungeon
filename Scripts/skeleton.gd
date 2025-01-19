extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var SPEED = 70

#func _physics_process(delta: float) -> void:
	#var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	##velocity = direction * SPEED * delta
	##Поворачиваем спрайт лево-право по х кординате вектора(надо добавить верх-низ)
	#if direction.x == 1:
		#animated_sprite_2d.flip_h = true
	#elif direction.x == -1:
		#animated_sprite_2d.flip_h = false

	
