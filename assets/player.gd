extends CharacterBody2D

const SPEED = 600

var hp = 100.0

signal  health_depleted

#"move_left"	or	LEFT	= -1,0
#"move_right"	or	RIGHT	= 1,0
#"move_up"		or	UP		= 0,1
#"move_down"	or	DOWN 	= 0=-1
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * SPEED
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		hp -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = hp
		if hp <= 0.0:
			health_depleted.emit()
