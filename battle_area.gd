extends Node2D

@onready var target : Marker2D
const TIMER_MAX = 5 * 50
var timer = TIMER_MAX
const ENEMY = preload("res://enemy.tscn")

func _ready() -> void:
	print(target)

func _process(delta: float) -> void:
	if timer >= 0:
		timer -= 1 
	else:
		spawnar_enemy()
		timer = TIMER_MAX
		
func spawnar_enemy():
	var spawners = get_tree().get_nodes_in_group("spawners")
	
	if spawners.size() == 0:
		return

	var inimigo = ENEMY.instantiate()
	get_tree().current_scene.add_child(inimigo)
	
	var spawner = spawners.pick_random()
	inimigo.global_position = spawner.global_position
