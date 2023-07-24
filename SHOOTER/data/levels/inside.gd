extends LevelParent


# GATE SIGNAL.
func _on_exit_gate_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	# LOAD TO OUTSIDE SCENE.
	TransitionLayer.transition("res://data/levels/outside.tscn")
