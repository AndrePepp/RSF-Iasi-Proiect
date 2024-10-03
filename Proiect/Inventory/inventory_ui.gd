@tool

extends Control

@onready var inv: Inv = preload("res://Inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = true

func _ready():
	inv.update_slot.connect(update_slots)
	update_slots()
	close()

func update_slots():
	#for i in range(min(inv.slots.size(), slots.size())):
		#slots[i].update(inv.slots[i])
	pass

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		print("i")
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
