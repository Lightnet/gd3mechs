tool
extends EditorPlugin

func _enter_tree():
    # Initialization of the plugin goes here
    add_custom_type("MyButton", "Button", preload("button.gd"), preload("./icon.png"))
    pass

func _exit_tree():
    # Clean-up of the plugin goes here
    remove_custom_type("MyButton")
    pass