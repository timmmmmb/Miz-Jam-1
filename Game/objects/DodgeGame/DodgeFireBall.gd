extends Area2D

export (int) var speed = 25

func _physics_process(delta):
	position.y += speed * delta


func _on_DodgeFireBall_body_entered(body):
	if !body.is_in_group("player"):
#		possible animation
		queue_free()
