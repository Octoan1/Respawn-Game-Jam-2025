extends Node

# base ui node 
@onready var ui = get_tree().get_current_scene().find_child("UI")

# menu handling 
@onready var pause_menu = ui.find_child("PauseMenu")
@onready var end_screen = ui.find_child("GameEndScreen")

# start menu
@onready var start_menu = ui.find_child("StartMenu")
@onready var play_button = ui.find_child("PlayButton")
# info menu
@onready var info_menu = ui.find_child("InfoScreen")
@onready var continue_button = ui.find_child("ContinueButton")

# crosshair handling 
@onready var crosshair = ui.find_child("Crosshair")
@onready var default_crosshair = crosshair.find_child("DefaultCrosshair")
@onready var interaction_crosshair = crosshair.find_child("InteractionCrosshair")

enum UIState {
	START_MENU,
	INFO_MENU,
	NORMAL, 
	PAUSED,
	GAME_END
}

enum CrosshairState {
	DEFAULT,
	CAN_INTERACT
}

var current_crosshair_state: CrosshairState = CrosshairState.DEFAULT
var current_ui_state: UIState = UIState.NORMAL

func _ready():
	play_button.pressed.connect(_on_play_button_pressed)
	continue_button.pressed.connect(_on_continue_button_pressed)
	current_ui_state = UIState.START_MENU

func _on_play_button_pressed():
	print("hello")
	start_menu.visible = false
	info_menu.visible = true
	current_ui_state = UIState.INFO_MENU
	#set_paused(false)
	
func _on_continue_button_pressed():
	print("continued")
	info_menu.visible = false
	set_paused(false)
	current_ui_state = UIState.NORMAL

func toggle_pause():
	set_paused(current_ui_state != UIState.PAUSED)
	
func set_paused(paused: bool):
	if current_ui_state == UIState.START_MENU or current_ui_state == UIState.INFO_MENU:
		return
	
	if current_ui_state == UIState.GAME_END:
		return  # ignore crosshair updates during game end
	
	current_ui_state = UIState.PAUSED if paused else UIState.NORMAL
	
	var gems_collected_label: Label = pause_menu.find_child("Gems Collected")
	gems_collected_label.text = "Gems Collected: %d/24" %GameManager.score
	
	#get_tree().paused = paused
	GlobalTime.stopped = paused
	pause_menu.visible = paused
	crosshair.visible = !paused
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if paused else Input.MOUSE_MODE_CAPTURED)


func update_crosshair(state: CrosshairState):
	if current_ui_state == UIState.GAME_END:
		return  # ignore crosshair updates during game end
	
	current_crosshair_state = state
	
	match current_crosshair_state:
		CrosshairState.DEFAULT:
			default_crosshair.visible = true
			interaction_crosshair.visible = false
		CrosshairState.CAN_INTERACT:
			interaction_crosshair.visible = true
			default_crosshair.visible = false
			
func set_game_end(score: int):
	current_ui_state = UIState.GAME_END
	var gems_collected_label: Label = end_screen.find_child("GemsCollected")
	var days_taken_label: Label = end_screen.find_child("DaysTaken")
	
	# update labels
	gems_collected_label.text = "Gems Collected: %d out of 24" %score
	days_taken_label.text = "Time Spent: %d days" %GlobalTime.day_counter
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# hide crosshair and all its children
	crosshair.visible = false
	default_crosshair.visible = false
	interaction_crosshair.visible = false
	GlobalTime.stopped = true
	
	end_screen.visible = true
	
