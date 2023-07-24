extends ItemContainer


func hit():
	if not is_opened:
		$AudioStreamPlayer2D.play()
		$LidImage.hide()
		var pos = $SpawnPosition.get_child(0).global_position
		open.emit(pos, current_direction)
		is_opened = true
