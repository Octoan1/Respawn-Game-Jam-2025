extends Node3D

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
		button.connect("InnerOuterRotate", Callable(self, "inner_outer_shift"))
		button.connect("OuterMiddleRotate", Callable(self, "outer_middle_shift"))

func inner_outer_shift() -> void:
	if(InnerRing.get_state() != 4):
		InnerRing.set_state(InnerRing.get_state() + 1)
	elif(InnerRing.get_state() == 4):
		InnerRing.set_state(0)
	
	if(OuterRing.get_state() != 4):
		OuterRing.set_state(OuterRing.get_state() + 1)
	elif(OuterRing.get_state() == 4):
		OuterRing.set_state(0)
	
	#purely visual for the player
	InnerRing.choose_rotation()
	OuterRing.choose_rotation()
	
	check_correct()
	
	print("Outer state: ", OuterRing.get_state())
	print("Middle state: ", MiddleRing.get_state())
	print("Inner state: ", InnerRing.get_state())

func outer_middle_shift() -> void:
	if(MiddleRing.get_state() != 4):
		MiddleRing.set_state(MiddleRing.get_state() + 1)
	elif(MiddleRing.get_state() == 4):
		MiddleRing.set_state(0)
	
	if(OuterRing.get_state() != 4):
		OuterRing.set_state(OuterRing.get_state() + 1)
	elif(OuterRing.get_state() == 4):
		OuterRing.set_state(0)
	
	#purely visual for the player
	OuterRing.choose_rotation()
	MiddleRing.choose_rotation()
	
	check_correct()
	
	
	print("Outer state: ", OuterRing.get_state())
	print("Middle state: ", MiddleRing.get_state())
	print("Inner state: ", InnerRing.get_state())

# Starting states are: outer;2  inner;3  middle;0
#
func check_correct() -> void:
	var outerState = OuterRing.get_state()
	var innerState = InnerRing.get_state()
	var middleState = MiddleRing.get_state()
	
	if(outerState == 4 && middleState == 3 && innerState == 2):
		print("Winner!")
