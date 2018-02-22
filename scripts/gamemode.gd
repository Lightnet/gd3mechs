extends Node

var player = null
var gameplay = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if gameplay != null:
		if gameplay.has_method("update"):
			gameplay.update()
		pass
	pass

func set_gameplay(value):
	gameplay = value

func check_death():
	pass

func update_score():
	pass