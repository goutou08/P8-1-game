extends CharacterBody2D

const SPEED := 200.0

func _physics_process(_delta: float) -> void:
	var dir := Vector2.ZERO

	# 水平：A / D 或 左 / 右
	dir.x = int(Input.is_key_pressed(KEY_D) or Input.is_action_pressed("ui_right")) \
		- int(Input.is_key_pressed(KEY_A) or Input.is_action_pressed("ui_left"))

	# 垂直：W / S 或 上 / 下
	dir.y = int(Input.is_key_pressed(KEY_S) or Input.is_action_pressed("ui_down")) \
		- int(Input.is_key_pressed(KEY_W) or Input.is_action_pressed("ui_up"))

	if dir != Vector2.ZERO:
		dir = dir.normalized()

	velocity = dir * SPEED
	move_and_slide()
