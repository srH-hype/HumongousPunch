extends "res://Enemy.gd"

var changeState = true

const needle = preload("res://needle.tscn")

func _ready():
	if direction == -1:
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	speed = 70
	hp = 6
	rageSpeed = 210
	Gravity = 35

func _on_timerHit_timeout():
	$Particles2D.visible = false

func _process(delta):
	if life == true:
		if $attackChecker1.is_colliding(): 
			
			if attacking == false && life == true && is_on_floor() && loading == false:
				attacking = true
				$timerCD.start()
				var needleV = needle.instance()
				needleV.set_direction(1)
				get_parent().add_child(needleV)
				needleV.position  = $Position2D.global_position
				$AnimatedSprite.flip_h = false
		if $attackChecker2.is_colliding():
			if attacking == false && life == true && is_on_floor() && loading == false:
				attacking = true
				$timerCD.start()
				var needleV = needle.instance()
				needleV.set_direction(-1)
				get_parent().add_child(needleV)
				needleV.position  = $Position2D.global_position
				$AnimatedSprite.flip_h = true
	
	if life == true:
		stateAttack(changeState)
	


func stateAttack(change):
	if change == true:
		if attacking == true:
			$AnimatedSprite.play("attack")
			changeState = false

func _on_timerCD_timeout():
	attacking = false
	loading = false
	changeState = true
