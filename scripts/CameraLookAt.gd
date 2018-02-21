extends Node

var camera
var obj
var target_dir = Vector3(0,0,0)

export (NodePath) var objpath
var objnode
var sphere
func _ready():
	#camera = get_node("/root/Node/Spatial/Camera")
	#obj = get_node("MeshInstance")
	#if objpath !=null:
		#objnode = get_node(objpath)
	#sphere = get_node("Sphere")
	set_process(true)
	pass
	
var angle = 0

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	#get_global_transform
	
	#var target = objnode.global_transform.origin
	#var from = self.global_transform.origin
	
	#var target_dir = (target -  from).normalized()
	#target_dir.y = 0
	#print(target_dir)
	##obj.look_at(target_dir,Vector3(0,1,0))
	#target_dir = Vector3(0,1,0)
	#target_dir.x += 0.01
	
	#if target_dir.x > 1:
		#target_dir.x = 0
	#target_dir.x = dir.x
	#target_dir.z = dir.z
	#print(target_dir)
	#sphere.transform.origin = target_dir
	#obj.look_at(target_dir,Vector3(0,1,0))
	#look_at(target_dir,Vector3(0,1,0))
	#looking_at(target_dir,Vector3(0,1,0))
	#look_at_from_position(self.global_transform.origin,objnode.global_transform.origin,Vector3(0,1,0))
	
	var target = get_viewport().get_camera().global_transform.origin
	look_at_from_position(self.global_transform.origin,target,Vector3(0,1,0))
	
	
	
	
	
	pass
