extends Node

var equips = []

func _ready():
	
	equips.append({"name":"Light","gear":"body"})
	equips.append({"name":"Medium","gear":"body"})
	equips.append({"name":"Heavy","gear":"body"})
	
	equips.append({"name":"Head1","gear":"head"})
	equips.append({"name":"Head2","gear":"head"})
	equips.append({"name":"Head3","gear":"head"})
	
	equips.append({"name":"Rfile","gear":"weapon"})
	equips.append({"name":"Shotgun","gear":"weapon"})
	equips.append({"name":"LightMachineGun","gear":"weapon"})
	equips.append({"name":"Sniper","gear":"weapon"})
	
	equips.append({"name":"Light","gear":"legs"})
	equips.append({"name":"Medium","gear":"legs"})
	equips.append({"name":"Heavy","gear":"legs"})
	
	equips.append({"name":"Jet Back","gear":"back"})
	equips.append({"name":"Missile","gear":"back"})
	equips.append({"name":"Booster","gear":"back"})
	
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
