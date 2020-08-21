extends KinematicBody2D

var velocity = Vector2()
export (int) var run_speed = 100


func get_input():
	velocity.x = 0
	velocity.y = 0
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")

	if left:
		velocity.x -= run_speed
	elif right:
		velocity.x += run_speed


func _physics_process(_delta):
	get_input()
	$AnimatedSprite.animation = "run"
	velocity = move_and_slide(velocity, Vector2(0, -1))
