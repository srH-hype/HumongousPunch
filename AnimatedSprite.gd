extends "res://Enemy.gd"

var changeState = true

func _ready():
	if direction == -1:
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	speed = 10
	hp = 10
	rageSpeed = 140
	Gravity = 70
