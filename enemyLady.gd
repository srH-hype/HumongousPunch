extends "res://Enemy.gd"

var changeState = true

func _ready():
	direction = -1
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	speed = 80
	hp = 4
	rageSpeed = 560
	Gravity = 30
	

func _process(delta):
	
	if life == true:
		stateAttack(changeState)
	
	
	if life == true:
		if $attackChecker1.is_colliding() || $attackChecker2.is_colliding() || $attackChecker3.is_colliding(): 
			if attacking == false && life == true && is_on_floor() && loading == false:
				attacking = true
				$timerCD.start()
				$timerAttack.start()
				$timerDZ.start()
	
	


func stateAttack(change):
	if change == true:
		if attacking == true:
			$AnimatedSprite.play("attack")
			changeState = false


func _on_AreaDamage1_body_entered(body):
	body.hitHope(position.x)
	$AreaDamage1.set_collision_mask_bit(0, false)
	$AreaDamage2.set_collision_mask_bit(0, false)
	$AreaDamage3.set_collision_mask_bit(0, false)
	loading = true


func _on_AreaDamage2_body_entered(body):
	body.hitHope(position.x)
	$AreaDamage1.set_collision_mask_bit(0, false)
	$AreaDamage2.set_collision_mask_bit(0, false)
	$AreaDamage3.set_collision_mask_bit(0, false)
	loading = true

func _on_AreaDamage3_body_entered(body):
	body.hitHope(position.x)
	$AreaDamage1.set_collision_mask_bit(0, false)
	$AreaDamage2.set_collision_mask_bit(0, false)
	$AreaDamage3.set_collision_mask_bit(0, false)
	loading = true


func _on_timerCD_timeout():
	attacking = false
	loading = false
	changeState = true


func _on_timerDZ_timeout():
	$AreaDamage1.set_collision_mask_bit(0, false)
	$AreaDamage2.set_collision_mask_bit(0, false)
	$AreaDamage3.set_collision_mask_bit(0, false)
	loading = true


func _on_timerAttack_timeout():
	$AreaDamage1.set_collision_mask_bit(0, true)
	$AreaDamage2.set_collision_mask_bit(0, true)
	$AreaDamage3.set_collision_mask_bit(0, true)
	$AnimatedSprite.play("load")
	loading = true

func _on_Fallzone_body_entered(body):
	hp = 0


func _on_timerHit_timeout():
	$Particles2D.visible = false
