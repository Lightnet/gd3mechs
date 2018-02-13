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

var angle = 0

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
	setbaserotation(delta)
	setpitchrotation(delta)
	
	
	#turret_base = turret_base.rotated( Vector3(0,1,0), deg2rad(20) * delta)
	#var up = Vector3(0,1,0)
	#turret_base = turret_base.looking_at(basepos, up)
	#skeleton.set_bone_pose( boneid, turret_base )
	#print("test")
	#bonename = "turret"
	#boneid = skeleton.find_bone(bonename)
	#var turret_pitch = skeleton.get_bone_pose(boneid)
	#pitchpos.x = 0
	#pitchpos.z = 0
	#turret_pitch = turret_pitch.looking_at(pitchpos, up)
	#skeleton.set_bone_pose( boneid, turret_pitch )
	#pass
	"""
	var chassis_transform = get_parent().get_global_transform()
	#var turret_transform = get_global_transform()
	var turret_transform = skeleton.get_bone_pose(boneid)
	# vector for rotation axis of turret
	var turret_up = chassis_transform.basis.y.normalized()
	# plane trough turret
	var p1 = turret_transform.origin
	var p2 = p1 + turret_transform.basis.x
	var p3 = p1 + turret_transform.basis.z
	var plane = Plane(p1, p2, p3)
	var look_at = plane.project(pitchpos)
	if(typeof(look_at) == TYPE_VECTOR3):
		var x = (look_at - turret_transform.origin).normalized()
		var y = turret_up.normalized()
		var z = x.cross(y).normalized()
		var quaternion_current = Quat(turret_transform.basis)
		var quaternion_new = quaternion_current.slerp(Basis(x, y, z), delta*3.0)
		#set_global_transform(Transform(quaternion_new, turret_transform.origin))
		var trans = Transform(quaternion_new, turret_transform.origin)
		skeleton.set_bone_pose( boneid, trans )
	"""
	#var turret_pitch = skeleton.get_bone_pose(boneid)
	#turret_pitch.rotate((get_transform().basis.y).normalized(),get_transform().basis.y.angle_to(Vector3))
	#skeleton.set_bone_pose( boneid, turret_pitch )
	
func setbaserotation(delta):
	bonename = "Base"
	boneid = skeleton.find_bone(bonename)
	var chassis_transformb = get_parent().get_global_transform()
	var turret_baseb = skeleton.get_bone_pose(boneid)
	
	var turret_upb = chassis_transformb.basis.y.normalized()
	var p1b = turret_baseb.origin
	var p2b = p1b + turret_baseb.basis.x
	var p3b = p1b + turret_baseb.basis.z
	
	var planeb = Plane(p1b, p2b, p3b)
	var look_atb = planeb.project(pitchpos)
	if(typeof(look_atb) == TYPE_VECTOR3):
		var xb = (look_atb - turret_baseb.origin).normalized()
		var yb = turret_upb.normalized()
		var zb = xb.cross(yb).normalized()
		var quaternion_current = Quat(turret_baseb.basis)
		var quaternion_newb = quaternion_current.slerp(Basis(xb, yb, zb), delta*3.0)
		#set_global_transform(Transform(quaternion_new, turret_transform.origin))
		var transb = Transform(quaternion_newb, turret_baseb.origin)
		skeleton.set_bone_pose( boneid, transb )

func setpitchrotation(delta):
	bonename = "turret"
	boneid = skeleton.find_bone(bonename)
	
	var chassis_transform = get_parent().get_global_transform()
	var turret_transform = skeleton.get_bone_pose(boneid)
	# vector for rotation axis of turret
	var turret_up = chassis_transform.basis.x.normalized()
	# plane trough turret
	#var p1 = turret_transform.origin
	var p1 = turret_transform.origin + turret_transform.basis.x
	var p2 = turret_transform.origin + turret_transform.basis.z
	var p3 = turret_transform.origin
	var plane = Plane(p1, p2, p3)
	var look_at = plane.project(pitchpos)
	if(typeof(look_at) == TYPE_VECTOR3):
		var z = (look_at - turret_transform.origin).normalized()
		var x = turret_up.normalized()
		var y = x.cross(z).normalized()
		
		var quaternion_current = Quat(turret_transform.basis)
		var quaternion_new = quaternion_current.slerp(Basis(x, y, z), delta*3.0)
		#set_global_transform(Transform(quaternion_new, turret_transform.origin))
		var trans = Transform(quaternion_new, turret_transform.origin)
		skeleton.set_bone_pose( boneid, trans )
	pass

func _on_ButtonLeft_pressed():
	angle += 10
	var rot = Quat(Vector3(0, 1, 0), deg2rad(angle))
	#var rot = Quat(Vector3(0, 1, 0), value * -1)
	var t = get_parent().get_global_transform()
	get_parent().set_transform(Transform(rot, t.origin))
	pass # replace with function body


func _on_ButtonRight_pressed():
	angle -= 10
	var rot = Quat(Vector3(0, 1, 0), deg2rad(angle))
	#var rot = Quat(Vector3(0, 1, 0), value * -1)
	var t = get_parent().get_global_transform()
	get_parent().set_transform(Transform(rot, t.origin))
	pass # replace with function body
