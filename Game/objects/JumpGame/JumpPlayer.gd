extends KinematicBody2D

signal loose

export (int) var run_speed = 100
export (int) var jump_speed = -300
export (int) var gravity = 800

var velocity = Vector2()
var jumping = false

func get_input():
	velocity.x = 0
	var jump = Input.is_action_just_pressed('jump')
	
	if jump and is_on_floor():
		$JumpSound.play()
		jumping = true
		velocity.y = jump_speed
	velocity.x += run_speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor() && velocity.y > 0:
		jumping = false
	if jumping:
		$AnimatedSprite.animation = "jump"
	elif velocity.x != 0:
		$AnimatedSprite.animation = "run"
	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("loose")
