extends KinematicBody

# You may need to adjust depending on the sensitivity of your mouse
const MOUSE_SENSITIVITY = 0.05

var view_sensitivity = 0.10
const ACCEL= 2
const DEACCEL= 4
const MAX_SPEED = 10
slave var slave_vel = Vector3()

export(NodePath) var node_hand_right
export(NodePath) var node_hand_left

var weapon_right
var weapon_left

#var mouse_pos = Vector2()
#var toggle_mouse = false

var last_position = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if node_hand_right != null:
		weapon_right = get_node(node_hand_right)
	if node_hand_left != null:
		weapon_left = get_node(node_hand_left)
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
		
	# Print the size of the viewport
	#print("Viewport Resolution is: ", get_viewport().size)
	#print("Mouse Position is: ", get_viewport().get_mouse_position())
	
	if event is InputEventMouseMotion:
		#print(event.get_property_list())
		#print(last_position)
		var delta = event.position - last_position
		last_position = event.position
		#check diff from mouse center drag
		"""
		if last_position.x <= 510:
		#if last_position.x <= 511:
			if delta.x < 0:
				self.rotate_y(-delta.x * view_sensitivity)
		if last_position.x >= 512:
		#if last_position.x >= 511:
			if delta.x > 0:
				self.rotate_y(-delta.x * view_sensitivity)
		"""
		#http://docs.godotengine.org/en/latest/tutorials/3d/fps_tutorial/part_one.html
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		#print(delta.x)
		
	if event.is_action_pressed("Fire"):
		#print("fire")
		if weapon_right != null:
			#print("has fun?")
			if weapon_right.has_method("fire"):
				print("found fire")
				weapon_right.fire()
		pass