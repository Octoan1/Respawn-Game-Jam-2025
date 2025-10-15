extends Node3D
class_name Interactable

#@export var interable: bool = false

signal interacted()

func interact():
	interacted.emit()
