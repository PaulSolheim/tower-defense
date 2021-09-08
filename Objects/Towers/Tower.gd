class_name Tower
extends Node2D

signal sold(price, place)
signal selected(selected)

export var cost := 100

onready var _weapon := $Weapon2D
onready var _interface := $Interface
onready var _cooldown_bar := $UICooldownBar
onready var _selection := $SelectableArea2D

func _ready() -> void:
	_weapon.show_range()

func show_interface() -> void:
	_weapon.show_range()
	_interface.appear()

func hide_interface() -> void:
	_weapon.hide_range()
	_interface.disappear()

func _on_SelectableArea2D_selection_changed(selected):
	if selected:
		show_interface()
	else:
		hide_interface()
	
	emit_signal("selected", selected)

func _on_SellButton_pressed():
	emit_signal("sold", cost / 2, position)
	queue_free()

func _on_Weapon2D_fired():
	_cooldown_bar.start(_weapon.fire_cooldown)
