extends CharacterBody2D

const SPEED = 200

#"move_left"	or	LEFT	= -1,0
#"move_right"	or	RIGHT	= 1,0
#"move_up"		or	UP		= 0,1
#"move_down"	or	DOWN 	= 0=-1
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * SPEED
	move_and_slide()
