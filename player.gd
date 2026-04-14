extends CharacterBody2D

@onready var ponta: Marker2D = $ponta
@onready var particles: GPUParticles2D = $particles

const BULLET = preload("res://fireball.tscn")
const acceleration = 200.00
const TURN_SPD = 5.00
const SPEED = 300.00
const CD_MAX = 10
var cooldown = CD_MAX
var mouseaim = true
var hiperdashing = false
func _process(delta: float) -> void:
	
	if cooldown >= 0:
		cooldown -= 1
	
	if Input.is_action_just_pressed("ctrlflip"):
		mouseaim = !mouseaim

		
	if !hiperdashing:
		if mouseaim:
			look_at(get_global_mouse_position())
		if !mouseaim:
			arrowsctrl(delta)
		if Input.is_action_pressed("accelerate"):
			accelerate(delta)
		if Input.is_action_pressed("brake"):
			brake(delta)
			
	if Input.is_action_just_pressed("ui_accept"):
		hiperdash()
	if Input.is_action_pressed("fire") and cooldown <= 0 and !hiperdashing:
		fire()
		
	move_and_slide()

func accelerate(delta:float):
	velocity += transform.x * SPEED * delta  

func brake(delta:float):
	velocity -= transform.x * (SPEED/2) * delta
func fire():
		var instance_bullet = BULLET.instantiate()
		get_tree().current_scene.add_child(instance_bullet)
		instance_bullet.global_position = ponta.global_position
		instance_bullet.rotation = rotation
		cooldown = CD_MAX

func arrowsctrl(delta):
	rotation += Input.get_axis("left","right") * TURN_SPD *delta

func hiperdash():
	if hiperdashing:
		return
	hiperdashing = true
	Engine.time_scale = 0.2
	await get_tree().create_timer(0.2).timeout
	particles.emitting = true
	Engine.time_scale = 1
	velocity += transform.x * SPEED * 10
	await get_tree().create_timer(0.15).timeout
	velocity *= 0.2
	
	await get_tree().create_timer(0.3).timeout
	particles.emitting = false
	hiperdashing = false
