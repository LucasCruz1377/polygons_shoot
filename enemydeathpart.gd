extends GPUParticles2D
@onready var som: AudioStreamPlayer2D = $som


func _ready() -> void:
	som.pitch_scale = 1 + randf_range(-0.3,0.3) 
	print( "variacao:  "+str(som.pitch_scale))
	await get_tree().create_timer(2).timeout
	queue_free()

	
