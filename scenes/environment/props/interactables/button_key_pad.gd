extends Node3D

@export var key_num: int
var default_color : Color = Color("white")
var clicked_color : Color = Color("gray")

func _ready() -> void:
	if self.get_child(0).material_override == null:
		self.get_child(0).material_override = StandardMaterial3D.new()

func _on_key_interacted() -> void:
	self.get_parent().code[0] = self.get_parent().code[1]
	self.get_parent().code[1] = self.get_parent().code[2]
	self.get_parent().code[2] = key_num
	
	self.get_child(0).material_override.albedo_color = clicked_color
	await get_tree().create_timer(1.0).timeout
	self.get_child(0).material_override.albedo_color = default_color
