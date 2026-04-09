extends CharacterBody2D

var speed: float = 600.0
var direction: Vector2 = Vector2.ZERO
var bounces_left: int = 10

func init(start_pos: Vector2, start_dir: Vector2, bounce_limit: int):
	position = start_pos
	direction = start_dir.normalized()
	bounces_left = bounce_limit

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
		bounces_left -= 1
		if bounces_left <= 0:
			queue_free()
