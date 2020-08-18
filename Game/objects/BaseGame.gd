extends Node2D

signal loose

var paused = false

func setPaused(p):
	paused = p
	if(paused):
		pause_mode = PAUSE_MODE_STOP
	else:
		pause_mode = PAUSE_MODE_PROCESS

func _ready():
	setPaused(paused)
