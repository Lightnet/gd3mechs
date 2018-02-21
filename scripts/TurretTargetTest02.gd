extends Spatial

var camera
var mouse_pos = Vector2()
var point
#var dir = Vector3()
var skeleton
var bonename
var boneid
#var base = Vector3()
var basepos = Vector3()
var pitchpos = Vector3()

var angle = 0

func _ready():
	camera = get_node("/root/Node/Spatial/Camera")
	skeleton = get_node("Armature/Skeleton")
	set_process(true)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position

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
		#dir = (hit.position - get_global_transform().origin).normalized()
		#basepos = hit.position * -1 #default?
		basepos = hit.position
		#basepos.y = 0
		#pitchpos = hit.position * -1
		pitchpos = hit.position
		#pitchpos.x = 0
	setbaserotation(delta)
	setpitchrotation(delta)

func setbaserotation(delta):
	bonename = "Base"
	boneid = skeleton.find_bone(bonename)
	var chassis_transform = get_parent().get_global_transform()
	var turret_transform = skeleton.get_bone_pose(boneid)

	# vector for rotation axis of turret
	var turret_up = chassis_transform.basis.y.normalized()

	# plane trough turret
	var p1 = turret_transform.origin
	var p2 = p1 + turret_transform.basis.x
	var p3 = p1 + turret_transform.basis.z

	var plane = Plane(p1, p2, p3)
	var look_at = plane.project(basepos)
	if typeof(look_at) == TYPE_VECTOR3:
		var x = (look_at - turret_transform.origin).normalized()
		var y = turret_up.normalized()
		var z = x.cross(y).normalized()
		var quaternion_current = Quat(turret_transform.basis)
		var dir = Basis(x, y, z)
		dir = dir.rotated( Vector3(0,1,0), deg2rad(90))
		var quaternion_new = quaternion_current.slerp(dir, delta*3.0)
		var transb = Transform(quaternion_new, turret_transform.origin)

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
	#var p2 = p1 + turret_transform.basis.x
	#var p3 = p1 + turret_transform.basis.z

	var p1 = turret_transform.origin + turret_transform.basis.y
	var p2 = turret_transform.origin
	var p3 = turret_transform.origin + turret_transform.basis.z

	var plane = Plane(p1, p2, p3)
	var look_at = plane.project(pitchpos * -1)
	if typeof(look_at) == TYPE_VECTOR3:
		#var x = (look_at - turret_transform.origin).normalized()
		#var y = turret_up.normalized()
		#var z = x.cross(y).normalized()

		var x = turret_up.normalized()
		var y = (look_at - turret_transform.origin).normalized()
		var z = x.cross(y).normalized()
		
		var quaternion_current = Quat(turret_transform.basis)
		
		var dir = Basis(x, y, z)
		dir = dir.rotated( Vector3(1,0,0), deg2rad(90)) #rotate x
		dir = dir.rotated( Vector3(0,1,0), deg2rad(180)) #rotate inverse
		var quaternion_new = quaternion_current.slerp( dir , delta*3.0)
		var transb = Transform(quaternion_new, turret_transform.origin)
		skeleton.set_bone_pose( boneid, transb )
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
