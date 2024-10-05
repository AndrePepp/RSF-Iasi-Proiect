extends Control


@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var inv: Inv = preload("res://Inventory/playerInv.tres")

var is_open = true
var past = false
var can_continue = true

func _ready():
    inv.update_slot.connect(update_slots)
    update_slots()
    close()

func update_slots():
    for i in range(min(inv.slots.size(), slots.size())):
        slots[i].update(inv.slots[i])

func _process(_delta):                              
    can_interact()
    if Input.is_key_pressed(KEY_TAB) and can_continue:
        if is_open:
            close()
        else:
            open()

func can_interact():
    if Input.is_key_pressed(KEY_TAB) != past:
        can_continue = true
    else:
        can_continue = false
    past = Input.is_key_pressed(KEY_TAB) 

func open():
    visible = true
    is_open = true

func close():
    visible = false
    is_open = false
