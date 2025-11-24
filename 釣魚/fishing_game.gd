extends Control

var score = 0
var time_left = 5.0
var game_over = false

@onready var ui = $UI
@onready var score_label = $UI/Score
@onready var timer_label = $UI/TimerLabel
@onready var game_over_overlay = $GameOverOverlay
@onready var game_over_label = $GameOverOverlay/VBoxContainer/GameOverLabel
@onready var final_score_label = $GameOverOverlay/VBoxContainer/FinalScoreLabel
@onready var fish_spawner = $fishspawner

func _ready():
	game_over_overlay.visible = false
	set_process(true)

func _process(delta):
	if game_over:
		return

	time_left -= delta
	if time_left <= 0:
		time_left = 0
		_end_game()

	timer_label.text = "Time: %.0f" % time_left

func add_score(points: int):
	if not game_over:
		score += points
		score_label.text = "Score: %d" % score

func _end_game():
	game_over = true
	set_process(false)

	game_over_overlay.visible = true
	game_over_overlay.modulate = Color(0, 0, 0, 0.6)  # 半透明暗背景
	game_over_label.text = "TIME'S OVER"
	final_score_label.text = "Final Score: %d" % score

	# 停止魚的移動
	for fish in $AquaContainer.get_children():
		if fish.has_method("set_physics_process"):
			fish.set_physics_process(false)
