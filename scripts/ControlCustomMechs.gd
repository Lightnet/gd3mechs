extends Control

var nodemech

func _ready():
	nodemech =get_node("../../Spatial/MeshInstance")
	print(nodemech)
	pass

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
		#nodemech.rotate_y(angle)
		#print(String(value))
		var rot = Quat(Vector3(0, 1, 0), value * -1)
		var t = nodemech.get_transform()
		
		nodemech.set_transform(Transform(rot, t.origin))
		
		
		pass
	pass