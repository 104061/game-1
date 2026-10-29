extends Area2D

@export var bullet_damage = 1
var speed = 1000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_bullet_body_entered(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		if body.has_method("take_damage"):
			body.take_damage(bullet_damage)
	queue_free()
