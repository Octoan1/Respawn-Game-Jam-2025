extends Node3D
var off_cooldown = false
var solution = []

var move_sun_button = false
var move_moon_button = false
var move_star_button = false
var move_hourglass_button = false

var movement = false

var speed = 0.6
var reset_speed = 1.4
var puzzle_complete = false
var reset_button = false


@onready
var SunButton = $SunButton
@onready
var sun_start = SunButton.position.y
@onready
var MoonButton = $MoonButton
@onready
var moon_start = MoonButton.position.y
@onready
var StarButton = $StarButton
@onready
var star_start = StarButton.position.y
@onready
var HourglassButton = $HourglassButton
@onready
var hourglass_start = HourglassButton.position.y

#sounds
const BUTTON_PRESS = preload("uid://db20s06eccs8k")
@onready var press = $press
const STONESLIDING = preload("uid://dca3akkbbitk5")
@onready var reset = $reset

signal move_walls


# this takes parameter from signal connected FROM player script.
# player script detects bodys entering the area3D, and this script will make
# sure only player activates a button
func star_button_pressed(body: Node3D) -> void:
	if(body.name=="Player"):
		if(off_cooldown == true):
			press.play()
			reset_button = false
			move_star_button = true
			solution.append("star")
			
			off_cooldown = false
			$ButtonCooldown.start()
			
			solution_check()
			reset_buttons()
			


func moon_button_pressed(body: Node3D) -> void:
	print(body.name)
	if(body.name=="Player"):
		if(off_cooldown == true):
			press.play()
			reset_button = false
			move_moon_button = true
			print("Moon button pressed")
			solution.append("moon")
			
			# cooldown stuffs
			off_cooldown = false
			$ButtonCooldown.start()
			
			solution_check()
			reset_buttons()

func hourglass_button_pressed(body: Node3D) -> void:
	if(body.name=="Player"):
		if(off_cooldown == true):
			press.play()
			reset_button = false
			move_hourglass_button = true
			solution.append("hourglass")
			
			off_cooldown = false
			$ButtonCooldown.start()
			
			solution_check()
			reset_buttons()

func sun_button_pressed(body: Node3D) -> void:
	if(body.name=="Player"):
		if(off_cooldown == true):
				press.play()
				reset_button = false
				move_sun_button = true
				solution.append("sun")
				
				off_cooldown = false
				$ButtonCooldown.start()
				
				solution_check()
				reset_buttons()
			

# Code: Sun moon star hourglass
func solution_check() -> void:
	if(!puzzle_complete):
		if(solution.get(0) == "sun" && solution.get(1) == "moon" && solution.get(2) == "star" && solution.get(3) == "hourglass"):
			puzzle_complete = true
			emit_signal("move_walls")

func reset_buttons() -> void:
	if(move_sun_button == true && move_moon_button == true && move_hourglass_button == true && move_star_button == true && puzzle_complete == false):
		reset.play()
		move_sun_button = false
		move_moon_button = false
		move_hourglass_button = false
		move_star_button = false
		
		reset_button = true
		solution = []

func on_cooldown() -> void:
	if(movement == false):
		off_cooldown = true
	else:
		$ButtonCooldown.start()


func _process(delta: float) -> void:
	if(move_sun_button == true):
		if(SunButton.position.y >= sun_start-0.3):
			SunButton.position.y = SunButton.position.y - delta*speed
			movement = true
		else:
			movement = false

	
	if(move_moon_button == true):
		if(MoonButton.position.y >= moon_start-0.3):
			MoonButton.position.y = MoonButton.position.y - delta*speed
			movement = true
		else:
			movement = false

	
	if(move_star_button == true):
		if(StarButton.position.y >= star_start-0.3):
			StarButton.position.y = StarButton.position.y - delta*speed
			movement = true
		else:
			movement = false
	
	if(move_hourglass_button == true):
		if(HourglassButton.position.y >= hourglass_start-0.3):
			HourglassButton.position.y = HourglassButton.position.y - delta*speed
			movement = true
		else:
			movement = false

	
	if(reset_button == true):
		if(MoonButton.position.y <= moon_start):
			MoonButton.position.y = MoonButton.position.y + delta*reset_speed
			movement = true
		else:
			movement = false
		if(SunButton.position.y <= sun_start):
			SunButton.position.y = SunButton.position.y + delta*reset_speed
			movement = true
		else:
			movement = false
		if(StarButton.position.y <= star_start):
			StarButton.position.y = StarButton.position.y + delta*reset_speed
			movement = true
		else:
			movement = false
		if(HourglassButton.position.y <= hourglass_start):
			HourglassButton.position.y = HourglassButton.position.y + delta*reset_speed
			movement = true
		else:
			movement = false
