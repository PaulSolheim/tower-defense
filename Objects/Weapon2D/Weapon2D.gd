class_name Weapon2D
extends Node2D

export var bullet_scene: PackedScene
signal fired

onready var _bullet_spawn_position := $BulletSpawnPosition2D
onready var _cooldown_timer := $CooldownTimer
onready var _range_area := $RangeArea2D
onready var _animation_player := $AnimationPlayer
onready var _range_shape: CircleShape2D = $RangeArea2D/CollisionShape2D.shape
onready var _range_preview := $RangePreview

export var fire_range := 200.0 setget set_fire_range
export var fire_cooldown := 1.0

func _ready() -> void:
	set_fire_range(fire_range)
	show_range()

func set_fire_range(new_range: float) -> void:
	fire_range = new_range
	
	if not is_inside_tree():
		yield(self, "ready")
	
	_range_shape.radius = fire_range

func show_range() -> void:
	_range_preview.radius = fire_range
	_range_preview.appear()

func hide_range() -> void:
	_range_preview.disappear()
