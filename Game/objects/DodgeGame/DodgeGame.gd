extends "res://objects/BaseGame.gd"

func _on_DodgeEnemy_loose():
	print("Dodge Game lost")
	emit_signal("loose")

func _on_Timer_timeout():
	$Tutorial.visible = false
