# Autoload (Project Settings > Globals > Autoload), nommé GameManager.
# Pas de class_name ici : Godot refuse une classe qui porte le nom d'un autoload.
extends Node

signal score_changed(score: int)
signal player_life_changed(life: int)
signal game_over

var score: int = 0

# --- 1.5
func add_score(points: int) -> void:
	score += points
	score_changed.emit(score)

func trigger_game_over() -> void:
	get_tree().paused = true
	game_over.emit()

func restart() -> void:
	score = 0
	get_tree().paused = false
	get_tree().reload_current_scene()
