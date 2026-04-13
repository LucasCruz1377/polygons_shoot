extends CharacterBody2D

@onready var firehole: Marker2D = $Marker2D

const BULLET = preload("res://fireball.tscn")
const acceleration = 200.00
const TURN_SPD = 5.00
const SPEED = 300.00
const CD_MAX = 20

var cooldown = CD_MAX
var mouseaim = true

func _process(delta: float) -> void:
	if cooldown >= 0:
		cooldown -= 1
	
	if Input.is_action_just_pressed("ctrlflip"):
		mouseaim = !mouseaim
	if mouseaim:
		look_at(get_global_mouse_position())
	if !mouseaim:
		arrowsctrl(delta)
	if Input.is_action_pressed("accelerate"):
		accelerate(delta)
	if Input.is_action_pressed("brake"):
		brake(delta)
	move_and_slide()
	if Input.is_action_pressed("fire") and cooldown <= 0 :
		fire()

func accelerate(delta:float):
	velocity += transform.x * SPEED * delta  

func brake(delta:float):
	velocity -= transform.x * (SPEED/2) * delta
func fire():
		var instance_bullet = BULLET.instantiate()
		get_tree().root.add_child(instance_bullet)
		instance_bullet.global_position = firehole.global_position
		instance_bullet.rotation = rotation
		cooldown = CD_MAX

func arrowsctrl(delta):
	rotation += Input.get_axis("left","right") * TURN_SPD *delta
