extends KinematicBody2D

var velocity = Vector2()
export (int) var run_speed = 100

func get_input():
	velocity.x = 0
	velocity.y = 0
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
		
	if left:
		velocity.x -= run_speed
		rotation_degrees = -90
	elif right:
		velocity.x += run_speed
		rotation_degrees = 90
	elif up:
		velocity.y -= run_speed
		rotation_degrees = 0
	elif down:
		velocity.y += run_speed
		rotation_degrees = 180
	

func _physics_process(_delta):
	get_input()
	$AnimatedSprite.animation = "swim"
	velocity = move_and_slide(velocity, Vector2(0, -1))
