extends MeshInstance3D

func _ready() -> void:
	if material_override == null:
		material_override = StandardMaterial3D.new()
	material_override.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material_override.albedo_color = Color(0.0, 2.844, 0.0, 0.0)
	
func _process(delta: float) -> void:
	var t = GlobalTime.time_of_day

	if t < 12.0:
		material_override.albedo_color.a = 0.0
		visible = false
	elif t >= 12.0 and material_override.albedo_color.a < 1.0:
		visible = true
		material_override.albedo_color.a = clamp(material_override.albedo_color.a + 0.1 * delta, 0.0, 1.0)
