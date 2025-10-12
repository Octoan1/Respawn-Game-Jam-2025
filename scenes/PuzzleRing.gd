extends Node3D

@export var ring_name: String
@export var state: int
@export var rotation_speed: float = TAU * 2
var theta : float
var direction: Vector3
var target_angle_x = 0

func get_state() -> int:
	return self.state

func get_ring() -> String:
	return self.ring_name

func set_state(input) -> void:
	self.state = input

func choose_rotation() -> void:
	# choose target angle
	target_angle_x = deg_to_rad(72)
	print("rotation angle: ", 72*state)
	print("rotation radians: ", deg_to_rad(72 * state))
	#snapping angle
	#self.rotate_x(72*state)
	self.rotate_x(deg_to_rad(72))

func _physics_process(delta: float) -> void:
	
	# this kinda works
	if target_angle_x:
		# Smoothly rotate towards the target_angle_x
		# Calculate the difference in rotation
		var angle_diff = wrapf(target_angle_x - self.rotation.x, -PI, PI)
		# Apply a smooth rotation
		self.rotate_x(clamp(rotation_speed * delta, 0, abs(angle_diff)) * sign(angle_diff))
		#self.rotation.x = lerp_angle(self.rotation.x, target_angle_x, rotation_speed*delta)
