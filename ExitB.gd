extends Button



func _on_ExitB_pressed():
	get_tree().quit()


func _on_ExitB_mouse_entered():
	$TextureRect5.visible = true
	$TextureRect6.visible = true


func _on_ExitB_mouse_exited():
	$TextureRect5.visible = false
	$TextureRect6.visible = false

