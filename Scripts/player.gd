extends CharacterBody2D

@onready var target: CharacterBody2D = $"../Target"
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

var speed = 50

#func _physics_process(delta: float) -> void:
	#var dir = to_local(nav_agent.get_next_path_position().normalized())
	#velocity = dir * speed
	#move_and_slide()
func _physics_process(_delta: float) -> void:
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	velocity = dir * speed
	move_and_slide()

func makepath():
	nav_agent.target_position = target.posision

func _on_timer_timeout() -> void:
	makepath()
