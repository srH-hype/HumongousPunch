extends Node2D

var level ="res://world-1/level1-3.tscn"
var nextLevel="res://world-2/level2-1.tscn"
var enemyNum = 6


func _process(delta):
	if $Hope.life == false:
		get_tree().change_scene(level)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused == false:
			$Hope/HUD/Label.text = "Pause"
			$Hope/HUD/Label.visible = true
			get_tree().paused = true
		else:
			$Hope/HUD/Label.visible = false
			get_tree().paused = false
			


func _on_Enemy_enemy_destroy():
	enemyNum = enemyNum - 1
	if enemyNum == 0:
		$Hope/HUD/Label.text = "Next Level"
		$Hope/HUD/Label.visible = true
		$timerNext.start()


func _on_Fallzone_body_entered(body):
	body.hp = 0


func _on_timerNext_timeout():
	get_tree().change_scene(nextLevel)
