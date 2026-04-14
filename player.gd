extends CharacterBody2D

@export var DeathParticle : PackedScene
@onready var ponta: Marker2D = $ponta
@onready var particles: GPUParticles2D = $particles
@onready var health_bar: ProgressBar = $"../CanvasLayer/Fundo"

const BULLET = preload("res://fireball.tscn")
const acceleration = 200.00
const TURN_SPD = 5.00
const SPEED = 300.00
const CD_MAX = 10
const MAX_HEALTH = 100

var health = MAX_HEALTH
var cooldown = CD_MAX
var mouseaim = true
var hiperdashing = false
func _process(delta: float) -> void:
	health_bar.value = health
	
	position.x = wrap(position.x,0,4000)
	position.y = wrap(position.y,0,2500)
	
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
	for i in get_slide_collision_count():
		var colisao = get_slide_collision(i)
		var corpo = colisao.get_collider()
		if corpo.is_in_group("enemies"):
			tomar_dano(corpo)
	

func tomar_dano(corpo):
	health -= corpo.dmg
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
func die():
	if health <= 0:
		var _particle = DeathParticle.instantiate()
		_particle.position = global_position
		_particle.rotation = global_rotation
		_particle.emitting = true
		get_tree().current_scene.add_child(_particle)
