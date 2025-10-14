extends Node3D

@onready var sub_viewport := $Objects/PlayerPostProcess/PostProcessViewport

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # optional for mouse look

func _unhandled_input(event):
	if sub_viewport:
		sub_viewport.push_input(event)
