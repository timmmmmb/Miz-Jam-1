extends Node2D

func _process(delta):
	var accept = Input.is_action_just_pressed("ui_accept")
	if accept:
		$Enter.play()
		yield($Enter, "finished")
		get_tree().change_scene("res://objects/Main.tscn")
	
