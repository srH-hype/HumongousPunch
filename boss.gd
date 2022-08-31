extends KinematicBody2D

var Gravity = 42
var velocity = Vector2(0,0)
var hp = 100
var life = true
var direction = -1
var speed = 210
var attaking = false
signal enemy_destroy
var dashing = false
var spining = false

func _physics_process(delta):
	if life == true:
		velocity.y = velocity.y + Gravity
		if attaking == false:
			velocity.x = speed * direction
		velocity = move_and_slide(velocity, Vector2.UP)
	
	
	if hp <= 0:
		destroy()

func hit(var posx, var dash):
	$hit.play()
	$Particles2D.emitting = true
	hp = hp-1

func hitUP(var posx):
	$hit.play()
	$Particles2D.emitting = true
	hp = hp-2

func destroy():
	$destroy.play()
	if life == true:
		emit_signal("enemy_destroy")
	life = false
	$AnimatedSprite.play("destroy")

func controlPoint1():
	randomAttack()
	direction = 1
	$AnimatedSprite.flip_h = false
	if speed == 900 :
		$".".set_collision_layer_bit(1, true)
		dashing = false
		speed = 210
		$AnimatedSprite.play("dash3")
	if speed == 630:
		spining = false
		speed = 210
		$AnimatedSprite.play("spin3")

func controlPoint2():
	randomAttack()
	direction = -1
	$AnimatedSprite.flip_h = true
	if speed == 900:
		$".".set_collision_layer_bit(1, true)
		dashing = false
		speed = 210
		$AnimatedSprite.play("dash3")
	if speed == 630:
		spining = false
		speed = 210
		$AnimatedSprite.play("spin3")

func _on_AnimatedSprite_animation_finished():
	if dashing == true:
		$AnimatedSprite.play("dash2") 
		speed = 900
		$".".set_collision_layer_bit(1, false)
	if attaking == true:
		attaking = false
	if spining == true:
		$AnimatedSprite.play("spin2")
		speed = 630
		$spinArea/CollisionShape2D.disabled = false
	if life == false:
		queue_free()
	if speed == 210:
		$AnimatedSprite.play("wait")


func doDamage(body):
	body.hitHope(-position.x)

func randomAttack():
	var num = randi() % 4
	if num == 0:
		kick()
	if num == 1:
		split()
	if num == 2:
		dash()
	if num == 3:
		spin()

func kick():
	attaking = true
	$AnimatedSprite.play("kick")
	$timerAttack2.start()

func split():
	attaking = true
	$AnimatedSprite.play("split")
	$timerAttack.start()

func dash():
	attaking = true
	dashing = true
	$AnimatedSprite.play("dash1")

func spin():
	attaking = true
	spining = true
	$AnimatedSprite.play("spin1")

func _on_timerAttack_timeout():
	$splitArea/CollisionShape2D.disabled = false
	$timerDZ.start()

func _on_timerDZ_timeout():
	$splitArea/CollisionShape2D.disabled = true
	$kickArea1/CollisionShape2D.disabled = true
	$kickArea2/CollisionShape2D.disabled = true

func _on_timerAttack2_timeout():
	$kickArea1/CollisionShape2D.disabled = false
	$kickArea2/CollisionShape2D.disabled = false
	$timerDZ.start()
