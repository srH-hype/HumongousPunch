extends "res://Enemy.gd"

var changeState = true

func _ready():
	if direction == -1:
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	speed = 28
	hp = 6
	rageSpeed = 330
	Gravity = 49

func _process(delta):
	if life == true:
		stateAttack(changeState)
	

func stateAttack(change):
	if change == true:
		if attacking == true:
			$AnimatedSprite.play("attack")
			changeState = false


func _on_visionArea1_body_entered(body):
	if attacking == false && life == true && is_on_floor() && loading == false:
		attacking = true
		$timerCD.start()
		$timerAttack1.start()
		$timerDZ.start()
		$areaAttack1/AnimatedSprite.play("active")


func _on_visionArea2_body_entered(body):
	if attacking == false && life == true && is_on_floor() && loading == false:
		attacking = true
		$timerCD.start()
		$timerAttack2.start()
		$timerDZ.start()
		$areaAttack2/AnimatedSprite.play("active")

func _on_timerCD_timeout():
	attacking = false
	loading = false
	changeState = true
	$areaAttack1/AnimatedSprite.play("off")
	$areaAttack2/AnimatedSprite.play("off")


func _on_timerDZ_timeout():
	$areaAttack1.set_collision_mask_bit(0, false)
	$areaAttack2.set_collision_mask_bit(0, false)


func _on_areaAttack1_body_entered(body):
	body.hitHope(position.x)
	$areaAttack1.set_collision_mask_bit(0, false)
	loading = true

func _on_areaAttack2_body_entered(body):
	body.hitHope(position.x)
	$areaAttack2.set_collision_mask_bit(0, false)
	loading = true


func _on_timerAttack1_timeout():
	$areaAttack1.set_collision_mask_bit(0, true)
	$AnimatedSprite.play("load")


func _on_timerAttack2_timeout():
	$areaAttack2.set_collision_mask_bit(0, true)
	$AnimatedSprite.play("load")


func _on_timerHit_timeout():
	$Particles2D.visible = false
