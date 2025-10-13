extends Node

@export var fade_speed : float = 0.5
@export var reset_time : float = 24.0  # when the day ends
@export var fade_color : Color = Color.BLACK
@onready var fade_overlay : ColorRect = $CanvasLayer/FadeOverlay
@export var player_path : NodePath
@onready var player : Node = get_node_or_null(player_path)

@export var start_position : Vector3

@export var on : bool

var is_fading_out = false
var is_fading_in = false
var fade_progress = 0.0
var day_resetting = false

func _process(delta: float) -> void:
	# Check if it's time to reset the day
	if(on):
		if not day_resetting and GlobalTime.time_of_day >= reset_time:
			start_day_reset()
		
		# Handle fading
		if is_fading_out:
			fade_progress += delta * fade_speed
			fade_overlay.modulate.a = clamp(fade_progress, 0.0, 1.0)
			if fade_progress >= 1.0:
				is_fading_out = false
				perform_reset()
				is_fading_in = true
				fade_progress = 1.0

		elif is_fading_in:
			fade_progress -= delta * fade_speed
			fade_overlay.modulate.a = clamp(fade_progress, 0.0, 1.0)
			if fade_progress <= 0.0:
				is_fading_in = false
				day_resetting = false


func start_day_reset() -> void:
	day_resetting = true
	is_fading_out = true
	fade_progress = 0.0
	GlobalTime.stopped = true


func perform_reset() -> void:
	# Reset time
	GlobalTime.time_of_day = 0.0  # start of new day
	GlobalTime.stopped = false

	# Reset player position
	if player:
		player.global_position = start_position
		player.look_at(player.global_position - Vector3(0, 0, 1), Vector3.UP)
		
		var neck = player.get_node_or_null("Neck")
		if neck:
			neck.look_at(neck.global_position - Vector3(0,0,1), Vector3.UP)
		else:
			print("No Neck")
		
		var cam = neck.get_node_or_null("Camera3D")
		if cam:
			cam.look_at(cam.global_position - Vector3(0,0,1), Vector3.UP)
		else:
			print("No Cam")
