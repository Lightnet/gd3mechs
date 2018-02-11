extends Control

var nodemech
var btnequips
var equipgroups

var equipbox

var loadGears = preload("res://scripts/gears.gd")
var gears = loadGears.new()
var geartype = "body"


func _ready():
	#nodemech = get_node("../../Spatial/MeshInstance")
	#nodemech = get_node("../../Spatial/Scene Root")
	nodemech = get_node("../../Spatial/SObj")
	#print(nodemech)
	btnequips = get_node("MBEquips")
	equipgroups = btnequips.get_popup()
	equipgroups.add_item("Head")
	equipgroups.add_item("Shoulder")
	equipgroups.add_item("Back")
	equipgroups.add_item("Body")
	equipgroups.add_item("Arms")
	equipgroups.add_item("Legs")
	equipgroups.add_item("Parts")
	equipgroups.add_item("Hands")
	equipgroups.add_item("Weapons")
	
	
	equipgroups.connect("id_pressed", self, "_on_item_pressed")
	
	equipbox = get_node("Panel/ScrollContainer/VBoxContainerGears")
	#print(equipbox)
	
	print(gears.equips)
	gears._ready()
	for i in gears.equips:
		print(i.name)
	
	updatelist()
	pass
	
func _on_item_pressed(ID):
	var pop  = btnequips.get_popup()
	btnequips.set_text(equipgroups.get_item_text(ID))
	geartype = equipgroups.get_item_text(ID)
	updatelist()
	
func updatelist():
	#equipbox.remove_child()
	for child in equipbox.get_children():
		child.queue_free()
	
	for gear in gears.equips:
		if gear.gear.matchn(geartype):
			var btn = Button.new()
			#btn.name = "test"
			btn.set_text(gear.name)
			btn.connect("pressed", self, "_button_select", [btn])
			equipbox.add_child(btn)
	#pass
	
func _button_select(button):
	print(button.text)
	
	#pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_HSlider_value_changed( value ):
	if nodemech != null:
		#nodemech.rotate(Vector3(0,1,0),value * deg2rad(1))
		#nodemech.rotate_y(deg2rad(value))
		#deg2rad(value)
		#var angle = rad2deg(1)
		#var dir = 1
		#if value < 0:
			#dir = dir *-1
		#var angle = deg2rad(1 * dir)
		#nodemech.rotate_y(0.001)
		#print(String(value))
		var rot = Quat(Vector3(0, 1, 0), deg2rad(value))
		#var rot = Quat(Vector3(0, 1, 0), value * -1)
		var t = nodemech.get_transform()
		nodemech.set_transform(Transform(rot, t.origin))
		pass
	pass
