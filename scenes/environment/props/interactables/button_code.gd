extends Node3D

@export var num : int
@onready var press = $press
const BUTTON_PRESS = preload("uid://db20s06eccs8k")

func _on_button_code_interacted() -> void:
	if(!self.get_parent().moving):
		press.play()
		self.get_parent().code[0] = self.get_parent().code[1]
		self.get_parent().code[1] = self.get_parent().code[2]
		self.get_parent().code[2] = num
	
		self.global_position.x -= 0.1
		await get_tree().create_timer(0.5).timeout
		self.global_position.x += 0.1
