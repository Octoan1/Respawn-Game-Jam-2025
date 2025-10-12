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
	
	OuterRing.choose_rotation()
	MiddleRing.choose_rotation()
	InnerRing.choose_rotation()

func inner_outer_shift() -> void:
	if(InnerRing.get_state() != 5):
		InnerRing.set_state(InnerRing.get_state() + 1)
	elif(InnerRing.get_state() == 5):
		InnerRing.set_state(1)
	
	if(OuterRing.get_state() != 5):
		OuterRing.set_state(OuterRing.get_state() + 1)
	elif(OuterRing.get_state() == 5):
		OuterRing.set_state(1)
	
	#purely visual for the player
	InnerRing.choose_rotation()
	OuterRing.choose_rotation()
	
	check_correct()
	
	print("Outer state: ", OuterRing.get_state())
	print("Middle state: ", MiddleRing.get_state())
	print("Inner state: ", InnerRing.get_state())

func outer_middle_shift() -> void:
	if(MiddleRing.get_state() != 5):
		MiddleRing.set_state(MiddleRing.get_state() + 1)
	elif(MiddleRing.get_state() == 5):
		MiddleRing.set_state(1)
	
	if(OuterRing.get_state() != 5):
		OuterRing.set_state(OuterRing.get_state() + 1)
	elif(OuterRing.get_state() == 5):
		OuterRing.set_state(1)
	
	#purely visual for the player
	OuterRing.choose_rotation()
	MiddleRing.choose_rotation()
	
	check_correct()
	
	
	print("Outer state: ", OuterRing.get_state())
	print("Middle state: ", MiddleRing.get_state())
	print("Inner state: ", InnerRing.get_state())

# Starting states are: outer;2  middle;5 inner;3  
# States range from 1-5. When it is at state 5, it resets to state 1.
# (Resets from 360 degrees rotation to 72. So should be flush)
func check_correct() -> void:
	var outerState = OuterRing.get_state()
	var innerState = InnerRing.get_state()
	var middleState = MiddleRing.get_state()
	
	if(outerState == 4 && middleState == 3 && innerState == 2):
		print("Winner!")
