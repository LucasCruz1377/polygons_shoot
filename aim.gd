extends Node2D

@onready var player: CharacterBody2D = $"../CharacterBody2D"
@onready var anim: AnimationPlayer = $anim

func _ready() -> void:
	anim.play("shot")

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	
	if Input.is_action_pressed("fire"):
		anim.play("shot")
	else:
		anim.pause()
