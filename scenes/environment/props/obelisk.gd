extends Node3D
#This Obelisk is for the glow puzzle
@export var player_path : NodePath
@onready var player : Node = get_node_or_null(player_path)

@export var gem_path : NodePath
var activated = false
var destroyed = false

func _ready() -> void:
	activated = false
	destroyed = false


func _process(delta: float) -> void:
	var gem : Node = get_node_or_null(gem_path)
	if(gem != null):
		var dist = sqrt((player.global_position.x - self.global_position.x)**2 + (player.global_position.z - self.global_position.z)**2)
		if(dist <= 5 && Input.is_action_just_pressed("glow_interact") && !activated):
			activated = true
		if(activated && scale.x > 0):
			scale -= Vector3.ONE * 0.5 * delta
		elif(activated && gem.scale.x < 1):
			gem.scale += Vector3.ONE * 0.25 * delta
