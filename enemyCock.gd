extends "res://Enemy.gd"

var changeState = true

func _ready():
	if direction == -1:
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	speed = 21
	hp = 12
	rageSpeed = 140
	Gravity = 63


func _process(delta):
	if life == true:
		if $attackChecker1.is_colliding(): 
			
			if attacking == false && life == true && is_on_floor() && loading == false:
				attacking = true
				$timerCD.start()
				$timerAttack1.start()
				$timerDZ.start()
		if $attackChecker2.is_colliding():
			if attacking == false && life == true && is_on_floor() && loading == false:
				attacking = true
				$timerCD.start()
				$timerAttack2.start()
				$timerDZ.start()
	
	if life == true:
		stateAttack(changeState)
	


func _on_timerCD_timeout():
	attacking = false
	loading = false
	changeState = true

func _on_AreaDamage1_body_entered(body):
	body.hitHope(position.x)
	$AreaDamage1.set_collision_mask_bit(0, false)
	loading = true
	

func _on_AreaDamage2_body_entered(body):
	body.hitHope(position.x)
	$AreaDamage2.set_collision_mask_bit(0, false)
	loading = true
	

func stateAttack(change):
	if change == true:
		if attacking == true:
			$AnimatedSprite.play("attack")
			changeState = false


func _on_timerAttack1_timeout():
	$AreaDamage1.set_collision_mask_bit(0, true)
	$AnimatedSprite.play("load")

func _on_timerAttack2_timeout():
	$AreaDamage2.set_collision_mask_bit(0, true)
	$AnimatedSprite.play("load")

func _on_timerDZ_timeout():
	$AreaDamage1.set_collision_mask_bit(0, false)
	$AreaDamage2.set_collision_mask_bit(0, false)

func _on_Fallzone_body_entered(body):
	hp = 0


func _on_timerHit_timeout():
	$Particles2D.visible = false
