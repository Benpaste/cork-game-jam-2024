extends Label

@export var player: Player


func _process(delta: float) -> void:
	text = "ITEM %s" % Item.Types.find_key(player.STATS.item)
