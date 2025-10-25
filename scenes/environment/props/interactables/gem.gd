extends Node3D
class_name Gem

#@export var spawn_coords : Vector3 
@export var color: Color
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var particles = $CoolParticle
@onready var gemCollect = $gemCollect
const GEM_COLLECT = preload("uid://llpnbhibew7j")


func _ready() -> void:
	# set start position 
	#global_position = spawn_coords
	# set color
	if mesh.material_override == null:
		mesh.material_override = StandardMaterial3D.new()
	mesh.material_override.albedo_color = color
	
	#particles.find_child("GPUParticles3D").material_override.albedo_color = color


var t := 0.0
func _process(delta: float) -> void:
	t += 2 * delta
	position.y += sin(t) * .005
	mesh.rotate_y(PI/4 * delta)

func _on_gem_interacted() -> void:
	#print("-- gem interacted")
	GameManager.add_gem(self)
	particles.find_child("GPUParticles3D").emitting = true
	mesh.visible = false
	find_child("StaticBody3D").find_child("CollisionShape3D").disabled = true
	gemCollect.stream = GEM_COLLECT
	gemCollect.play()
	await get_tree().create_timer(1).timeout
	queue_free()
