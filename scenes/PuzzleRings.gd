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
		button.connect("InnerOuterRotate", Callable(self, "inner_outer_shift"))
		button.connect("OuterMiddleRotate", Callable(self, "outer_middle_shift"))

func inner_outer_shift() -> void:
	
	InnerRing.set_state(InnerRing.get_state() + 1)
	OuterRing.set_state(OuterRing.get_state() + 1)
	#purely visual for the player
	InnerRing.rotation()
	OuterRing.rotation()
	
	print("Outer state: ", OuterRing.get_state())
	print("Middle state: ", MiddleRing.get_state())
	print("Inner state: ", InnerRing.get_state())
	
	check_correct()
	check_overflow()

func outer_middle_shift() -> void:
	
	OuterRing.set_state(OuterRing.get_state() - 1)
	MiddleRing.set_state(MiddleRing.get_state() + 1)
	
	#purely visual for the player
	OuterRing.rotation()
	MiddleRing.rotation()
	
	print("Outer state: ", OuterRing.get_state())
	print("Middle state: ", MiddleRing.get_state())
	print("Inner state: ", InnerRing.get_state())
	
	check_correct()
	check_overflow()

# Starting states are: outer;2  inner;3  middle;0
#
func check_correct() -> void:
	var outerState = OuterRing.get_state()
	var innerState = InnerRing.get_state()
	var middleState = MiddleRing.get_state()
	
	if(outerState == 4 && middleState == 3 && innerState == 2):
		print("Winner!")

func check_overflow() -> void:
	if(OuterRing.get_state() >= 5):
		OuterRing.set_state(0)
	elif(OuterRing.get_state() <= 0):
		OuterRing.set_state(5)
	if(MiddleRing.get_state() >= 5):
		MiddleRing.set_state(0)
	if(InnerRing.get_state() >= 5):
		InnerRing.set_state(0)
