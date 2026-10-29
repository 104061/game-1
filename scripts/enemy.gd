extends CharacterBody2D

var health: int
var damage: int
var player_in_attack_reach: bool = false
var player: CharacterBody2D
@export var health_bar: ProgressBar
@export var timer: Timer
@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	setup_ready()
func setup_ready() -> void:
	health = randi() % 10 + 4
	damage = randi() % 3 + 1
	health_bar.max_value = health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player == null:
		return
		
	var direction := global_position.direction_to(player.global_position)
	
	velocity = direction * speed
	move_and_slide()

func on_player_body_enter(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		if body.has_method("take_damage"):
			player_in_attack_reach = true
			attack_player()

func on_player_body_exit(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		if body.has_method("take_damage"):
			player_in_attack_reach = false
			timer.stop()

func attack_player() -> void:
	if player_in_attack_reach:
		if player.has_method("take_damage"):
			player.take_damage(damage)
		timer.start()
func take_damage(amount: int) -> void:
	health -= amount
	health_bar.value = health

	if health <= 0:
		queue_free()
func on_attack_timeout() -> void:
	attack_player()
	
	if player_in_attack_reach:
		timer.start()
