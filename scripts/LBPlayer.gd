extends KinematicBody

var view_sensitivity = 0.25
const ACCEL= 2
const DEACCEL= 4
const MAX_SPEED = 10
slave var slave_vel = Vector3()

#var mouse_pos = Vector2()
#var toggle_mouse = false

var last_position = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func movecheck(delta):
	var dir = Vector3() # Where does the player intend to walk to
	var xform = get_global_transform()
	
	if Input.is_action_pressed("Up"):
		dir += -xform.basis[2]
		pass
	if Input.is_action_pressed("Down"):
		dir += xform.basis[2]
		pass
	dir.y = 0
	dir = dir.normalized()
	var hvel = slave_vel
	hvel.y = 0
	var target = dir*MAX_SPEED
	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL
	hvel = hvel.linear_interpolate(target, accel*delta)
	slave_vel.x = hvel.x
	slave_vel.z = hvel.z
	
	move_and_collide(slave_vel*delta)
	
func _physics_process(delta):
	#print("da")
	movecheck(delta)
	pass

func _input(event):
	if event.is_action_pressed("Escape"):
		get_tree().quit()
		pass
	
	if event is InputEventMouseMotion:
		#mouse_pos = Vector2(event.position.x,event.position.y)#event.pos to Vector2()
		#print(event.get_property_list())
		#print(last_position)
		var delta = event.position - last_position
		last_position = event.position
		#print(last_position)
		if last_position.x <= 510:
			print("left?")
			#self.rotate_y(1 * 0.01)
			if delta.x < 0:
				self.rotate_y(-delta.x * 0.01)
		if last_position.x >= 512:
			#self.rotate_y(-1 * 0.01)
			if delta.x > 0:
				self.rotate_y(-delta.x * 0.01)
		print(delta.x)
		#if 
			#print(delta.x)
			#self.rotate_y(-delta.x * 0.01)
	if event.is_action_pressed("Up"):
		#print("up")
		pass