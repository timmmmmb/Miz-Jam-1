extends Control
onready var jumpgame = get_node("ViewportContainer1/Viewport/JumpGame")
onready var squidgame = get_node("ViewportContainer2/Viewport/SquidGame")
onready var dodgegame = get_node("ViewportContainer3/Viewport/DodgeGame")
onready var truckgame = get_node("ViewportContainer4/Viewport/TruckGame")
onready var games = [jumpgame, squidgame, truckgame, dodgegame]
var starttime = OS.get_ticks_msec()
var currentScore = 0
var game_paused = false

func _ready():
	get_tree().paused = true
	game_paused = false
	restart()

func loose():
	game_paused = true
	for game in games:
		game.pause_mode = PAUSE_MODE_STOP

func restart():
	for game in games:
		game.pause_mode = PAUSE_MODE_STOP
	jumpgame.pause_mode = PAUSE_MODE_PROCESS
	starttime = OS.get_ticks_msec()
	currentScore = 0
	game_paused = false

func _process(_delta):
	if !game_paused:
		currentScore = OS.get_ticks_msec()-starttime
		if currentScore >= 15000 && squidgame.pause_mode == PAUSE_MODE_STOP:
			$AnimationPlayer.play("SquidGame")
		if currentScore >= 30000 && dodgegame.pause_mode == PAUSE_MODE_STOP:
			$AnimationPlayer.play("DodgeGame")
		if currentScore >= 45000 && truckgame.pause_mode == PAUSE_MODE_STOP:
			$AnimationPlayer.play("TruckGame")
		$ScoreLabel.text = str(currentScore)
	
	if(game_paused && Input.is_action_just_pressed('restart')):
		get_tree().reload_current_scene()
		restart()
