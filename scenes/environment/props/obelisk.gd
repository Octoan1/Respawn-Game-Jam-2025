extends Node3D
#This Obelisk is for the glow puzzle
@export var player_path : NodePath
@onready var player : Node = get_node_or_null(player_path)

func _process(_delta: float) -> void:
	var dist = sqrt((player.global_position.x - self.global_position.x)**2 + (player.global_position.z - self.global_position.z)**2)
	if(dist <= 5 && Input.is_action_just_pressed("glow_interact")):
		print("Glow Puzzle Winner")
