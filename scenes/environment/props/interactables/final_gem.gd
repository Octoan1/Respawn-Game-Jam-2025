extends "res://scenes/environment/props/interactables/gem.gd"

func _ready():
	#self.color = null
	super()

func _process(delta: float) -> void:
	t += delta
	position.y += sin(t) * 0.001
	mesh.rotate_y(PI / 4 * delta)
	
	# Rainbow effect
	var hue_speed := 0.2  # how fast the hue shifts
	var hue := fmod(t * hue_speed, 1.0)  # wraps between 0 and 1
	var rainbow_color := Color.from_hsv(hue, 1.0, 1.0)
	mesh.material_override.albedo_color = rainbow_color


func _on_gem_interacted() -> void:
	print("FINAL gem interacted")
	GameManager.end_game()
	particles.find_child("GPUParticles3D").emitting = true
	mesh.visible = false
	find_child("StaticBody3D").find_child("CollisionShape3D").disabled = true
	gemCollect.stream = GEM_COLLECT
	gemCollect.play()
	await get_tree().create_timer(1).timeout
	queue_free()
