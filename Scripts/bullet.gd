class_name Bullet

extends Area2D

@export var speed: float = 900.0

# --- 1.3 : le tir avance tout droit, dans la direction de sa rotation
func _physics_process(delta: float) -> void:
	position += Vector2.UP.rotated(rotation) * speed * delta
	if abs(position.y) > 1000.0:
		queue_free()
