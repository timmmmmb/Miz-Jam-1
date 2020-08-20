extends Node2D

signal loose

var dodge_fireball = preload("res://objects/DodgeGame/DodgeFireBall.tscn")

func _on_Timer_timeout():
	var fireball = dodge_fireball.instance()
	fireball.connect("body_entered", self, "fireball_hit")
	get_parent().add_child(fireball)
	fireball.position = position
	$FireballSound.play()
	
	
	
func fireball_hit(body):
	if body.is_in_group("player"):
		emit_signal("loose")
