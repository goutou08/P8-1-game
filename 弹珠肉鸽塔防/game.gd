extends Node2D

@export var bounce_limit: int = 10
@export var balls_per_attack: int = 1
@export var ball_interval_ms: int = 150
@export var attack_cooldown_ms: int = 2000

@onready var player = $CharacterBody2D

var ball_scene = preload("res://ball.tscn")
var screen_size: Vector2
var attack_timer: float = 0.0
var attack_cd: float = 0.0

func _ready():
	screen_size = get_viewport_rect().size
	player.position = Vector2(screen_size.x / 2, screen_size.y - 100)
	create_walls()

func create_walls() -> void:
	var walls = [
		# 上
		[Vector2(screen_size.x / 2, 0), Vector2(screen_size.x, 10)],
		# 下
		[Vector2(screen_size.x / 2, screen_size.y), Vector2(screen_size.x, 10)],
		# 左
		[Vector2(0, screen_size.y / 2), Vector2(10, screen_size.y)],
		# 右
		[Vector2(screen_size.x, screen_size.y / 2), Vector2(10, screen_size.y)],
	]
	for w in walls:
		var body = StaticBody2D.new()
		var col = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		shape.size = w[1]
		col.shape = shape
		body.add_child(col)
		add_child(body)
		body.position = w[0]
		
func _process(delta: float) -> void:
	attack_cd -= delta
	if attack_cd <= 0:
		attack_cd = attack_cooldown_ms / 1000.0
		fire_attack()

func fire_attack() -> void:
	for i in range(balls_per_attack):
		await get_tree().create_timer(i * ball_interval_ms / 1000.0).timeout
		spawn_ball()

func spawn_ball() -> void:
	var ball = ball_scene.instantiate()
	add_child(ball)
	ball.init(player.position, Vector2(0, -1), bounce_limit)
