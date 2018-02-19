extends Control

var mouse_pos = Vector2()
var toggle_mouse = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _input(event):
	
	
	"""
	if event is InputEventMouseMotion:
		mouse_pos = Vector2(event.position.x,event.position.y)#event.pos to Vector2()
		#print("move")
		pass
	#https://godotengine.org/qa/1155/way-to-change-what-cursor-looks-like-in-game-via-gdscript?show=18636#c18636
	if event.is_action_pressed("alt"):
		print("alt")
		if toggle_mouse:
			toggle_mouse = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			toggle_mouse = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pass
	
	#print("input")
	"""
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
