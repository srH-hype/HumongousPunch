extends Button



func _on_HowB_mouse_entered():
	$TextureRect3.visible = true
	$TextureRect4.visible = true


func _on_HowB_mouse_exited():
	$TextureRect3.visible = false
	$TextureRect4.visible = false


func _on_HowB_pressed():
	get_tree().change_scene("res://HowToPlay.tscn")
