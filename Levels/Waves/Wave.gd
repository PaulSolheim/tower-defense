class_name Wave
extends Path2D

signal starting
signal finished

export (float, 0.1, 5.0, 0.05) var enemy_time_interval := 0.5

# start test code, remove after testing complete
#func _ready() -> void:
#	start()
# end test code

func start() -> void:
	emit_signal("starting")
	_setup_enemies()
	_move_enemies()

func _setup_enemies() -> void:
	for enemy in get_children():
		enemy.unit_offset = 0.0
		enemy.connect("tree_exited", self, "_on_Enemy_tree_exited")

func _move_enemies() -> void:
	for enemy in get_children():
		yield(get_tree().create_timer(enemy_time_interval), "timeout")
		enemy.move()

func set_movement_path(movement_path: PoolVector2Array) -> void:
	curve.clear_points()
	for point in movement_path:
		curve.add_point(point)

func is_wave_finished() -> bool:
	return get_child_count() < 1

func _on_Enemy_tree_exited() -> void:
	if is_wave_finished():
		emit_signal("finished")
		queue_free()

