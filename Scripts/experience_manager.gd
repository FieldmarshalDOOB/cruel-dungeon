extends Node


var current_experience = 0

func _ready():
	Global.exp_bot_collected.connect(on_chest_looted)


func on_chest_looted(experiance):
	current_experience += experiance
	
