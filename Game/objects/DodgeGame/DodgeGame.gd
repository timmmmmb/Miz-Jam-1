extends "res://objects/BaseGame.gd"

func _on_DodgeEnemy_loose():
	print("Dodge Game lost")
	emit_signal("loose")
