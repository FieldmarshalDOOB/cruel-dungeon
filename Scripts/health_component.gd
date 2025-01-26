extends Node
class_name HealthComponent

signal died
@export var max_hralth = 100
var current_health


func _ready():
	current_health = max_hralth


func take_damage (damage):
	current_health = max(current_health-damage, 0)
	check_death()


func  check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()
