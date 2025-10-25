extends CharacterBody3D

#signal interact(target)

@export var SPEED: float = 15
@export var JUMP_VELOCITY: float = 6
var can_fly: bool = false

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D

# Coyote time stuff
var coyote_time_active := true

# Player light stuff
@onready var flash_light: SpotLight3D = $Neck/Camera3D/FlashLight
@onready var area_light: OmniLight3D = $AreaLight

func _process(delta: float) -> void:
	_player_lights()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		UIManager.set_paused(false)
	elif event.is_action_pressed("ui_cancel"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		UIManager.toggle_pause() 
	elif event.is_action_pressed("secret_button"):
		if SPEED < 100:
			SPEED = 100
			JUMP_VELOCITY = 20
			can_fly = true
		else:
			SPEED = 12
			JUMP_VELOCITY = 4.5
			can_fly = false
	elif event.is_action_pressed("time_forward"):
		GlobalTime.time_of_day += 1
	elif event.is_action_pressed("time_backward"):
		GlobalTime.time_of_day -= 1

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * Settings.MOUSE_X)
			camera.rotate_x(-event.relative.y * Settings.MOUSE_Y)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-88), deg_to_rad(88))


func _physics_process(delta: float) -> void:	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		if %CoyoteTimer.is_stopped():
			%CoyoteTimer.start()
	else:
		coyote_time_active = true
		%CoyoteTimer.stop()

	# Handle Jump.
	if Input.is_action_pressed("jump") and (coyote_time_active or can_fly):
		velocity.y = JUMP_VELOCITY
		
	# Interaction 
	if Input.is_action_just_pressed("interact") and interaction_target != null:
		var interactable : Interactable = interaction_target.find_child("Interactable")
		if interactable:
			#print("interacted with: ", interaction_target.name)
			interactable.interact()
		else:
			print("CANNOT interact with: ", interaction_target)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if (UIManager.current_ui_state == UIManager.UIState.NORMAL):
		move_and_slide()

#@onready var crosshair: TextureRect = $Head/Camera3D/Control/Crosshair
#@onready var crosshair_2: TextureRect = $Head/Camera3D/Control/Crosshair2
var interaction_target
func _on_interaction_ray_cast_looking_at(target: Node3D) -> void:
	#crosshair.visible = false
	#crosshair_2.visible = true
	if target.find_child("Interactable"):
		self.interaction_target = target
		UIManager.update_crosshair(UIManager.CrosshairState.CAN_INTERACT)


func _on_interaction_ray_cast_stopped_looking() -> void:
	#crosshair.visible = true
	#crosshair_2.visible = false
	interaction_target = null
	UIManager.update_crosshair(UIManager.CrosshairState.DEFAULT)


signal area_entered(data)

func _on_area_3d_body_entered(body: Node3D):
	emit_signal("area_entered", body)

func _on_coyote_timer_timeout() -> void:
	coyote_time_active = false

func _player_lights() -> void:
	if(GlobalTime.time_of_day > 12):
		area_light.omni_range = 3
		flash_light.spot_range = 50
	else:
		area_light.omni_range = 0
		flash_light.spot_range = 0
