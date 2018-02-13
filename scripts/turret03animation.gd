extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	var anim = get_node("AnimationPlayer")
	
	anim.play("up")
	pass # replace with function body


func _on_AnimationPlayer_animation_started( anim_name ):
	print("start animation?")
	pass # replace with function body


func _on_AnimationPlayer_animation_finished( anim_name ):
	print("finish animation?")
	pass # replace with function body
