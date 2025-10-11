extends Node3D

@export var ring_name: String
@export var state: int

func get_state() -> int:
	return self.state

func get_ring() -> String:
	return self.ring_name

func set_state(input) -> void:
	self.state = input

func rotation() -> void:
	self.rotate_x(72*state)
