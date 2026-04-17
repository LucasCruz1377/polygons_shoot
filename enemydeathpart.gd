extends GPUParticles2D
@onready var som: AudioStreamPlayer2D = $som

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	queue_free()

	som.pitch_scale = 1 + randf_range(0.1,0.2)
