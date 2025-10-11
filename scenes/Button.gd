extends Node3D

@export var button_name: String

signal outerRotate()
signal innerRotate()

func _ready():
	# if this is in a different main scene thing, change "RingPuzzle" to "main" etc.
	var emittor = get_node("/root/RingPuzzle/Player")
	if emittor:
		emittor.connect("area_entered", Callable(self, "button_pressed"))
	

# this takes parameter from signal connected FROM player script.
# player script detects bodys entering the area3D, and this script will make
# sure only player activates a button

func inner_button_pressed(body: Node3D) -> void:
	if(body.name=="Player"):
		print("Inner rotating now")
		emit_signal("innerRotate")


func outer_button_pressed(body: Node3D) -> void:
	if(body.name=="Player"):
		print("Outer rotating now")
		emit_signal("outerRotate")
