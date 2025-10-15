extends Node3D

#@export var spawn_coords : Vector3 
@export var color: Color

@onready var mesh: MeshInstance3D = $MeshInstance3D

func _ready() -> void:
	# set start position 
	#global_position = spawn_coords
	# set color
	if mesh.material_override == null:
		mesh.material_override = StandardMaterial3D.new()
	mesh.material_override.albedo_color = color


var t := 0.0
func _process(delta: float) -> void:
	t += delta
	position.y += sin(t) * 0.001
	rotate_y(PI/4 * delta)


func _on_gem_interacted() -> void:
	#print("-- gem interacted")
	GameManager.add_gem(self)
	queue_free()
