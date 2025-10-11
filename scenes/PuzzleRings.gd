extends Node3D

var state = 0;
@onready
var OuterRing = $OuterRing
@onready
var MiddleRing = $MiddleRing
@onready
var InnerRing = $InnerRing

func _ready():
	# if this is in a different main scene thing, change "RingPuzzle" to "main" etc.
	var button = get_node("/root/RingPuzzle/Buttons")
	if button:
		button.connect("innerRotate", Callable(self, "inner_shift"))
		button.connect("outerRotate", Callable(self, "outer_shift"))

func inner_shift() -> void:
	print("Inner ring shifting now.")
	print(InnerRing.get_state())
	InnerRing.set_state(InnerRing.get_state() + 1)
	InnerRing.rotation()

func outer_shift() -> void:
	print("Outer ring shifting now.")
	print(OuterRing.get_state())
	OuterRing.set_state(OuterRing.get_state() + 1)
	OuterRing.rotation()
