extends CanvasLayer

func _ready():
	$timerIntro.start()

func _on_timerIntro_timeout():
	$Label.visible = false
