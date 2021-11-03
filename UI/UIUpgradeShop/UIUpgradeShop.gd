class_name UpgradeShop
extends Control

export var _upgrade_button_scene: PackedScene

onready var _container := $Panel/VBoxContainer
onready var _anim_player := $AnimationPlayer
onready var _panel := $Panel

var player: Player

func _on_TowerPlacer_tower_placed(tower: Tower) -> void:
	tower.connect("selected", self, "_on_Tower_selected", [tower])
	tower.connect("sold", self, "_on_Tower_sold")

func _on_Tower_sold(_price: int, place: Vector2) -> void:
	_anim_player.play("Disappear")

func _update(tower: Tower) -> void:
	rect_global_position = tower.global_position
	
	# We remove any buttons before populating the container with new ones.
	for child in _container.get_children():
		child.queue_free()
	
	for upgrade in tower.get_upgrades():
		add_upgrade_button(upgrade)

# Uses rotation to ensure the interface is always in the view.
func _fit_panel_in_view() -> void:
	var center := get_viewport_rect().size * 0.5
	var angle := center.angle_to_point(rect_global_position - rect_pivot_offset)
	angle = round(angle / (PI / 4)) * (PI / 4)
	
	rect_rotation = rad2deg(angle)
	_panel.rect_rotation = - rect_rotation

func add_upgrade_button(upgrade: Upgrade) -> void:
	var button: UIUpgradeButton = _upgrade_button_scene.instance()
	button.connect("pressed", self, "_on_UIUpgradeButton_pressed", [button, upgrade])
	button.update_display(upgrade, player.gold)
	
	_container.add_child(button)

func _on_UIUpgradeButton_pressed(button: UIUpgradeButton, upgrade: Upgrade) -> void:
	if player.gold < upgrade.cost:
		return
	player.gold -= upgrade.cost
	upgrade.apply()
	button.update_display(upgrade, player.gold)

