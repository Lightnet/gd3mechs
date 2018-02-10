extends Spatial


var camera
var mouse_pos = Vector2()
var point
var dir = Vector3()
var skeleton
var bonename
var boneid
var base = Vector3()
var basepos = Vector3()
var pitchpos = Vector3()

func _ready():
	#var animationplayer = get_node("AnimationPlayer")
	#animationplayer.stop()
	camera = get_node("/root/Node/Spatial/Camera")
	#print(camera)
	#point = get_node("/root/Node/Spatial/Point")
	skeleton = get_node("Armature/Skeleton")
	#print(skeleton)
	#print(skeleton.find_bone("Armature_Base"))
	#print(skeleton.find_bone("Armature_turret"))
	set_process(true)
	
	#bonename = "turret"
	#pass
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = Vector2(event.position.x,event.position.y)#event.pos to Vector2()

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	# Project mouse into a 3D ray
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	
	# Cast a ray
	var from = ray_origin
	var to = ray_origin + ray_direction * 1000.0
	var space_state = get_world().get_direct_space_state()
	var hit = space_state.intersect_ray(from, to)
	if hit.size() != 0:
		#point.transform.origin = hit.position
		dir = (hit.position - get_global_transform().origin).normalized()
		basepos = hit.position * -1
		pitchpos = hit.position * -1
		basepos.y = 0
		#var face = dir*-1
		#var base = face
		#pitchpos = face
		#base.y = 0
		#print(base)
		#look_at(base,Vector3(0,1,0))
		#var boneid = skeleton.find_bone("Armature_Base")
		#var turret_base = skeleton.get_bone_pose(boneid)
		#turret_base.look_at(base,Vector3(0,1,0))
		#turret_base.looking_at(base,Vector3(0,1,0))
		#turret_base.rotated( Vector3(0,1,0), deg2rad(10) * delta)
		#skeleton.set_bone_pose( boneid, turret_base )
		#rotate( Vector3(0,1,0), deg2rad(10) )#works
		#point.transform.origin = hit.position
		#pass
	bonename = "Base"
	
	boneid = skeleton.find_bone(bonename)
	var turret_base = skeleton.get_bone_pose(boneid)
	#turret_base = turret_base.rotated( Vector3(0,1,0), deg2rad(20) * delta)
	var up = Vector3(0,1,0)
	turret_base = turret_base.looking_at(basepos, up)
	skeleton.set_bone_pose( boneid, turret_base )
	#print("test")
	bonename = "turret"
	boneid = skeleton.find_bone(bonename)
	var turret_pitch = skeleton.get_bone_pose(boneid)
	pitchpos.x = 0
	#pitchpos.z = 0
	turret_pitch = turret_pitch.looking_at(pitchpos, up)
	skeleton.set_bone_pose( boneid, turret_pitch )
	#pass
	
	
	
	
	
	
	
	
	