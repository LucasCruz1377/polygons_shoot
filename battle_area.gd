extends Node2D

@onready var target : Marker2D
const TIMER_MAX = 2 * 60
var timer = TIMER_MAX
const ENEMY = preload("res://enemy.tscn")
@onready var contpontos: Label = $CanvasLayer/Pontos
var pontos = 0

func _ready() -> void:
	print(target)

func _process(_delta: float) -> void:
	var pontos_tg = Global.Pontos
	
	if pontos < pontos_tg:
		pontos += 1
	
	contpontos.text = str(pontos) .pad_zeros(5)
	
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
