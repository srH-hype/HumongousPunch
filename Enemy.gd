extends KinematicBody2D

var Gravity = 0
var velocity = Vector2(0,0)
var hp = 0
var life = true
var direction = 1
var speed = 0
var rage = false
var attacking = false
var rageSpeed = 0
var change = true
var loading = false
var noDamage = false
signal enemy_destroy

func _physics_process(delta):
	
	if not is_on_floor() && life == true:
		$AnimatedSprite.play("air")
		
	
	elif is_on_floor() && life == true && rage == false  && loading == false:
		$AnimatedSprite.play("wait")
	
	if is_on_wall() or not $FloorChecker.is_colliding() and is_on_floor() and life == true:
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	if $visionChecker2.is_colliding() or $visionChecker1.is_colliding() && life == true:
		rage = true
		change = true
		if $visionChecker1.is_colliding() && $AnimatedSprite.flip_h == false && life == true && attacking == false:
			direction = direction * -1
			$AnimatedSprite.flip_h = true
		elif $visionChecker2.is_colliding() && $AnimatedSprite.flip_h == true && life == true && attacking == false:
			direction = direction * -1
			$AnimatedSprite.flip_h = false
	else:
		rage = false
	
	
	if rage == true && attacking == false && life == true:
		speed = rageSpeed
	elif attacking == false && life == true:
		speed = 30
	elif attacking == true:
		speed = 0
	
	if life == true:
		state_Change(change)
	
	velocity.y = velocity.y + Gravity
	
	if attacking == false or life == true:
		velocity.x = speed * direction
	else:
		velocity.x = 0
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	if hp <= 0:
		destroy()

func hit(var posx, var dash):
	$hit.play()
	$Particles2D.visible = true
	$timerHit.start()
	if dash == true:
		velocity.y = -800
		if position.x < posx:
			velocity.x = 770
		elif position.x > posx:
			velocity.x = -770
		hp = hp-1
	else:
		velocity.y = -560
		if position.x < posx:
			velocity.x = -70
		elif position.x > posx:
			velocity.x = 70
		hp = hp-1

func hitUP(var posx):
	$hit.play()
	$Particles2D.visible = true
	$timerHit.start()
	velocity.y = -700
	if position.x < posx:
		velocity.x = -140
	elif position.x > posx:
		velocity.x = 140
	hp = hp-2


func destroy():
	$destroy.play()
	rage = false
	if life == true:
		emit_signal("enemy_destroy")
	life = false
	$AnimatedSprite.play("destroy")

func _on_AnimatedSprite_animation_finished():
	if life == false:
		queue_free()


func state_Change(var changeA):
	if changeA == true :
		if rage == true && attacking == false:
			$AnimatedSprite.play("run")
			change = false


