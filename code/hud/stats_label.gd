extends Label

@export var player: Player


func _process(delta: float) -> void:
	text = "HP   %02d\nMP   %02d\nLIFE %02d" % [player.STATS.health, player.STATS.magic, player.STATS.lives]
