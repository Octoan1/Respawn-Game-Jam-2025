extends Node

# base ui node 
@onready var ui = get_tree().get_current_scene().find_child("UI")

# menu handling 
@onready var pause_menu = ui.find_child("PauseMenu")

# crosshair handling 
@onready var crosshair = ui.find_child("Crosshair")
@onready var default_crosshair = crosshair.find_child("DefaultCrosshair")
@onready var interaction_crosshair = crosshair.find_child("InteractionCrosshair")

enum UIState {
	NORMAL, 
	PAUSED
}

enum CrosshairState {
	DEFAULT,
	CAN_INTERACT
}

var current_crosshair_state: CrosshairState = CrosshairState.DEFAULT
var current_ui_state: UIState = UIState.NORMAL

func toggle_pause():
	set_paused(current_ui_state != UIState.PAUSED)
	
func set_paused(paused: bool):
	current_ui_state = UIState.PAUSED if paused else UIState.NORMAL
	
	#get_tree().paused = paused
	GlobalTime.stopped = paused
	pause_menu.visible = paused
	crosshair.visible = !paused
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if paused else Input.MOUSE_MODE_CAPTURED)


func update_crosshair(state: CrosshairState):
	current_crosshair_state = state
	
	match current_crosshair_state:
		CrosshairState.DEFAULT:
			default_crosshair.visible = true
			interaction_crosshair.visible = false
		CrosshairState.CAN_INTERACT:
			interaction_crosshair.visible = true
			default_crosshair.visible = false
