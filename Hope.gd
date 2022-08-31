extends KinematicBody2D

var velocity = Vector2(0,0)
var Speed = 140
var Gravity = 42
var jumpPower = -950
var is_attaking = false
var dash = 420
var is_dashing = false
var punchAReady = true
var punchBReady = true
var overheatA = 0
var overheatB = 0
var hp = 3
var comboA = false
var comboB = false
var hitting = false
var playable = true
var life = true

func _physics_process(delta):
	
	if playable == true:
		
		if Input.is_action_pressed("right"):
			if is_attaking == false || is_on_floor() == false and is_dashing ==false:
				velocity.x = Speed
				if is_attaking == false and is_dashing ==false:
					$HopeSprite.play("run")
					$HopeSprite.flip_h = false
		elif Input.is_action_pressed("left"):
			if is_attaking == false || is_on_floor() == false and is_dashing ==false:
				velocity.x = -Speed
				if is_attaking == false and is_dashing ==false:
					$HopeSprite.play("run")
					$HopeSprite.flip_h = true
		else:
			if is_attaking == false:
				$HopeSprite.play("wait")
			
		
		if not is_on_floor():
			if is_attaking == false:
				$HopeSprite.play("air")
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			$jump.play()
			if is_dashing == false:
				velocity.y = jumpPower
			else:
				velocity.y = jumpPower + 250
			$HopeSprite.play("air")
		
		if Input.is_action_just_pressed("punchA") && is_attaking == false && is_dashing == false:
			is_attaking = true
			comboB = true
			if comboA == false:
				if $HopeSprite.flip_h:
					$HopeSprite.play("punchA")
					$punchB.set_collision_mask_bit(1, true)
				else:
					$HopeSprite.play("punchB")
					$punchA.set_collision_mask_bit(1, true)
			elif comboA == true:
				comboA = false
				comboB = false
				if $HopeSprite.flip_h:
					$HopeSprite.play("UpperA")
					$UpperB.set_collision_mask_bit(1, true)
				else:
					$HopeSprite.play("UpperB")
					$UpperA.set_collision_mask_bit(1, true)
		
		if Input.is_action_just_pressed("punchB") && is_attaking == false  && is_dashing == false:
			is_attaking = true
			comboA = true
			if comboB == false:
				if $HopeSprite.flip_h:
					$HopeSprite.play("punchB")
					$punchB.set_collision_mask_bit(1, true)
				else:
					$HopeSprite.play("punchA")
					$punchA.set_collision_mask_bit(1, true)
			elif comboB == true:
				comboB = false
				comboA = false
				if $HopeSprite.flip_h:
					$HopeSprite.play("UpperB")
					$UpperB.set_collision_mask_bit(1, true)
				else:
					$HopeSprite.play("UpperA")
					$UpperA.set_collision_mask_bit(1, true)
		
		if Input.is_action_pressed("punchA"):
			if is_attaking == false and punchAReady == true:
				is_dashing = true
				overheatA = overheatA + 1
				$punchB.set_collision_mask_bit(1, true)
				Input.action_release("right")
				Input.action_release("left")
				if $HopeSprite.flip_h == false:
					 velocity.x = dash
					 $HopeSprite.play("dashB")
				else:
					velocity.x = -dash
					$HopeSprite.play("dashA") 
		
		if Input.is_action_pressed("punchB"):
			if is_attaking == false and punchBReady == true:
				is_dashing = true
				overheatB = overheatB + 1
				$punchA.set_collision_mask_bit(1, true)
				Input.action_release("right")
				Input.action_release("left")
				if $HopeSprite.flip_h == false:
					 velocity.x = dash
					 $HopeSprite.play("dashA")
				else:
					velocity.x = -dash
					$HopeSprite.play("dashB")
		
		if Input.is_action_just_pressed("down") and is_on_floor() and is_dashing == false:
			punchAReady = false
			punchBReady = false
		
		if overheatA == 35:
			punchAReady = false
			Input.action_release("punchA")
		
		if overheatB == 35:
			punchBReady = false
			Input.action_release("punchB")
		
		if punchAReady == false:
			
			overheatA = overheatA-0.5
		
		if punchBReady == false:
			
			overheatB = overheatB-0.5
		
		if overheatA <= 0:
			overheatA = 0
			punchAReady = true
		
		if overheatB <= 0:
			overheatB = 0
			punchBReady = true
		
		if is_dashing == true:
			Gravity = 14
		
		velocity.y = velocity.y + Gravity
		
		if Input.is_action_just_released("punchA"):
			is_dashing = false
		
		if Input.is_action_just_released("punchB"):
			is_dashing = false
		
		
		if is_attaking == false and is_dashing == false:
			$punchA.set_collision_mask_bit(1, false)
			$punchB.set_collision_mask_bit(1, false)
			$UpperA.set_collision_mask_bit(1, false)
			$UpperB.set_collision_mask_bit(1, false)
		
		if is_dashing == false:
			Gravity = 49 
		
		if velocity.y >= 800:
			velocity.y = 800
		
		velocity = move_and_slide(velocity, Vector2.UP)
		
		
		velocity.x = lerp(velocity.x,0,0.1)
		
		$HUD/overHeat1.value = overheatA
		$HUD/overHeat2.value = overheatB
		
		if hp == 2:
			$HUD/hp3.visible = false
		
		if hp == 1:
			$HUD/hp2.visible = false
	
	if hp == 0:
		$HUD/Label.text = "Game Over"
		$HUD/Label.visible = true
		playable = false
		gameOver()

func _on_HopeSprite_animation_finished():
	is_attaking = false
	if playable == false:
		life = false


func gameOver():
	$HopeSprite.play("gameOver")
	

func _on_punchA_body_entered(body):
	body.hit(position.x, is_dashing) 
	$punchA.set_collision_mask_bit(1, false)

func _on_punchB_body_entered(body):
	body.hit(position.x, is_dashing)
	$punchB.set_collision_mask_bit(1, false)

func _on_UpperA_body_entered(body):
	body.hitUP(position.x)

func _on_UpperB_body_entered(body):
	body.hitUP(position.x)

func hitHope(var posx):
	$hit.play()
	$ParticlesHit.visible = true
	$timerHit.start()
	velocity.y = -800
	if position.x < posx:
		velocity.x = -770
	elif position.x > posx:
		velocity.x = 770
	hp = hp-1


func _on_Fallzone_body_entered(body):
	body.hp = 0


func _on_timerHit_timeout():
	$ParticlesHit.visible = false
