extends Node3D

@export var button_name: String

var off_cooldown = false

signal OuterMiddleRotate()
signal InnerOuterRotate()

# this takes parameter from signal connected FROM player script.
# player script detects bodys entering the area3D, and this script will make
# sure only player activates a button
func inner_outer_button_pressed(body: Node3D) -> void:
	if(body.name=="Player"):
		if(off_cooldown == true):
			print("Inner rotating now")
			emit_signal("InnerOuterRotate")
			off_cooldown = false
			$ButtonCooldown.start()


func outer_middle_button_pressed(body: Node3D) -> void:
	
	if(body.name=="Player"):
		if(off_cooldown == true):
			print("Outer rotating now")
			emit_signal("OuterMiddleRotate")
			off_cooldown = false
			$ButtonCooldown.start()


func on_cooldown() -> void:
	off_cooldown = true
	print("Button cooldown refreshed!")
