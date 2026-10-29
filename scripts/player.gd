extends CharacterBody2D

@export var health = 10
@export var speed = 400
@export var bullet: PackedScene
@export var health_bar = ProgressBar

func get_input():
	var input_direction = Input.get_vector("left","right","up", "down")
	look_at(get_global_mouse_position())
	velocity = input_direction * speed

func shoot():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Marker2D.global_transform

func take_damage(amount: int) -> void:
	health -= amount
	health_bar.value = health
	if health == 0 || health <= 0:
		queue_free()

func _ready() -> void:
	health_bar.max_value = health
	

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	if Input.is_action_just_pressed("click"):
		shoot()
