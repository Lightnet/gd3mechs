extends Node

const projectile = preload("res://prefabs/projectiles/RBProjectile.tscn")
var firepoint

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	firepoint = get_node("FirePoint01")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func fire():
	if firepoint != null:
		print("fire projectile...")
		var xform = firepoint.get_global_transform()
		var face = xform.basis[2]
		face.y = 0
		face = face.normalized() * -1
		var target = face*3
		
		var objprojectile = projectile.instance()
		objprojectile.transform.origin = firepoint.get_global_transform().origin
		objprojectile.apply_impulse(firepoint.get_global_transform().origin,target*10)
		get_node("/root/Node").add_child(objprojectile)
		
		
	pass