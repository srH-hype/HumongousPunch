extends "res://Enemy.gd"

var changeState = true

func _ready():
	direction = -1
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	speed = 15
	hp = 3
	rageSpeed = 180
	Gravity = 35
	

func _process(delta):
	if life == true:
		stateAttack(changeState)
	

func _on_areaVision_body_entered(body):
	if attacking == false && life == true && is_on_floor() && loading == false:
		attacking = true
		$timerCD.start()
		$timerAttack.start()
		$timerDZ.start()
		$areaAttack/AnimatedSprite.visible = true

func _on_timerCD_timeout():
	attacking = false
	loading = false
	changeState = true

func stateAttack(change):
	if change == true:
		if attacking == true:
			$AnimatedSprite.play("attack")
			changeState = false


func _on_timerDZ_timeout():
	$areaAttack.set_collision_mask_bit(0, false)
	$areaAttack/AnimatedSprite.visible = false



func _on_timerAttack_timeout():
	$areaAttack.set_collision_mask_bit(0, true)
	$AnimatedSprite.play("load")


func _on_areaAttack_body_entered(body):
	body.hitHope(position.x)
	$areaAttack.set_collision_mask_bit(0, false)
	loading = true
	$areaAttack/AnimatedSprite.visible = false

func _on_Fallzone_body_entered(body):
	hp = 0


func _on_timerHit_timeout():
	$Particles2D.visible = false
