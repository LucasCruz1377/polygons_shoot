extends CharacterBody2D

const SPEED = 100.0
var hp = 1

func _physics_process(delta: float) -> void:
	seguir(delta)
	move_and_slide()
	
	if hp <= 0:
		queue_free()
func seguir(delta):
	var players = get_tree().get_nodes_in_group("player")
	
	if players.size() == 0:	
		return
	
	var target = players[0]
	
	var direcao = (target.global_position - global_position).normalized()
	
	velocity += direcao * SPEED * delta
	
	look_at(target.global_position)
	
