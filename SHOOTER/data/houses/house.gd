extends Area2D


signal player_entered_house
signal player_exited_house


func _on_body_entered(_body):
	player_entered_house.emit()


func _on_body_exited(_body):
	player_exited_house.emit()
