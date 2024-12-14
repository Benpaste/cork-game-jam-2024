extends Node
class_name PlayerStats

const MAX_HEALTH := 10
const MAX_MAGIC := 10
const START_LIVES := 3

var health := MAX_HEALTH:
	set(value):
		health = clampi(value, 0, MAX_HEALTH)
var magic := MAX_MAGIC:
	set(value):
		health = clampi(value, 0, MAX_MAGIC)
var lives := START_LIVES

var item := Item.Types.NONE


func apply_stats_pickup(pickup: StatsPickup) -> void:
	health += pickup.health
	magic += pickup.magic
	lives += pickup.lives


func apply_item(new_item: Item.Types) -> bool:
	if item == new_item:
		return false
	else:
		item = new_item
		return true


func reset() -> void:
	health = MAX_HEALTH
	magic = MAX_MAGIC
	item = Item.Types.NONE


func print_stats() -> void:
	print("health ", health)
	print("magic ", magic)
	print("lives ", lives)
	print("item ", item)
