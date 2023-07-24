extends ItemContainer


func hit():
	if not is_opened:
		$AudioStreamPlayer2D.play()
		$LidImage.hide()
		for i in range(5):
			var pos = $SpawnPosition.get_child(randi() % $SpawnPosition.get_child_count()).global_position
			open.emit(pos, current_direction)
		is_opened = true
