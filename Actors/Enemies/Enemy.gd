class_name Enemy
extends PathFollow2D

signal died(gold_amount)

export var speed := 64.0
export var max_health := 15
export var gold_value := 50

onready var health := max_health setget set_health

onready var _ui_pivot := $UIPivot
onready var _health_bar := $UIPivot/HealthBar
onready var _anim_player := $AnimationPlayer
onready var _cutout_anim_player := $CutoutCharacter/AnimationPlayer

func _ready() -> void:
	set_physics_process(false)
	_ui_pivot.set_as_toplevel(true)
	
	_health_bar.max_value = max_health
	_health_bar.value = health

func _physics_process(delta: float) -> void:
	offset += speed * delta
	
	if unit_offset >= 1.0:
		set_physics_process(false)
		disappear()

func move() -> void:
	set_physics_process(true)
	_cutout_anim_player.play("move")
	
func disappear() -> void:
	_anim_player.play("disappear")

func set_health(value: int) -> void:
	health = clamp(value, 0, max_health)
	_health_bar.value = health
	
	if health < 1:
		die()

func die() -> void:
	emit_signal("died", gold_value)
	disappear()


func _on_HurtBoxArea2D_hit_landed(damage):
	set_health(health - damage)
