extends Node

func _ready() -> void:
	$UITowerShop.player = $Player
	
	for i in 15:
		for j in 20:
			var cell := Vector2(i, j)
			$TowerPlacer.set_cell_placeable(cell)
