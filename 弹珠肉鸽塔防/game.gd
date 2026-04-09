extends Node2D

# ── 可配置参数 ──────────────────────────
@export var bounce_limit: int = 10        # 每颗弹珠最大弹射次数
@export var balls_per_attack: int = 1     # 每次攻击发射几颗弹珠
@export var ball_interval_ms: int = 150   # 同一次攻击中，每颗弹珠间隔(ms)
@export var attack_cooldown_ms: int = 2000 # 每次攻击的cd(ms)
# ────────────────────────────────────────

@onready var player = $CharacterBody2D

func _ready():
	var screen = get_viewport_rect().size
	player.position = Vector2(screen.x / 2, screen.y - 100)
