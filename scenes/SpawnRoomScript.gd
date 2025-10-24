extends Node3D

var moving = false
var won = false
var speed = 1

func _ready():
	# if this is in a different main scene thing, change "jump_puzzle" to "main" etc.
	$Gem.visible = false
	var button = %SpawnButtons
	if button:
		button.connect("move_walls", Callable(self, "walls_move"))
		

func walls_move() -> void:
	print("signal acquired")
	moving = true
	$Gem.visible = true

func _process(delta: float) -> void:
	var door = false
	if(moving == true and !won):
		if($Wall.position.y >= -15):
			$Wall.position.y = $Wall.position.y - delta*speed
		else:
			door = true
		if($Wall2.position.y >= -15):
			$Wall2.position.y = $Wall2.position.y - delta*speed
		else:
			door = true
		if($Wall3.position.y >= -15):
			$Wall3.position.y = $Wall3.position.y - delta*speed
		else:
			door = true
		if($Wall4.position.y >= -15):
			$Wall4.position.y = $Wall4.position.y - delta*speed
		else:
			door = true
		if(GameManager.score == 0):
			if($Gem):
				if($Gem.position.y >= 0.5):
					$Gem.position.y = $Gem.position.y - delta*2
		elif(door):
			won = true
