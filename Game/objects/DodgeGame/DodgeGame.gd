extends Node2D

signal loose

func _on_DodgeEnemy_loose():
	print("Dodge Game lost")
	emit_signal("loose")
