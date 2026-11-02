extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var lives: HBoxContainer = $Lives
@onready var damage_flash: ColorRect = $DamageFlash
@onready var game_over_panel: Control = $GameOverPanel

func _ready() -> void:
	GameManager.score_changed.connect(_on_score_changed)
	GameManager.player_life_changed.connect(_on_player_life_changed)
	GameManager.game_over.connect(_on_game_over)
	score_label.text = "%06d" % GameManager.score
	score_label.pivot_offset = score_label.size / 2

# --- 1.5
func _on_score_changed(score: int) -> void:
	score_label.text = "%06d" % score
	# Juice : le score "punch" à chaque gain
	score_label.scale = Vector2(1.4, 1.4)
	create_tween().tween_property(score_label, "scale", Vector2.ONE, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_player_life_changed(life: int) -> void:
	for i: int in lives.get_child_count():
		lives.get_child(i).visible = i < life
	# Juice : flash rouge plein écran
	damage_flash.color.a = 0.4
	create_tween().tween_property(damage_flash, "color:a", 0.0, 0.3)

func _on_game_over() -> void:
	game_over_panel.visible = true

func _on_restart_button_pressed() -> void:
	GameManager.restart()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
