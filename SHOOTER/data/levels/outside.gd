extends LevelParent


# GATE SIGNAL.
func _on_gate_player_entered_gate():
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	# LOAD TO INSDIE SCENE.
	TransitionLayer.transition("res://data/levels/inside.tscn")


# HOUSE SIGNAL.
func _on_house_player_entered_house():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1).set_trans(Tween.TRANS_QUAD)


func _on_house_player_exited_house():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
