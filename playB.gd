extends Button


func _on_playB_pressed():
	get_tree().change_scene("res://Lore.tscn")


func _on_playB_mouse_entered():
	$TextureRect.visible = true
	$TextureRect2.visible = true


func _on_playB_mouse_exited():
	$TextureRect.visible = false
	$TextureRect2.visible = false


