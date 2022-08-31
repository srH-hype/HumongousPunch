extends Area2D

const speed = 350
var velocity = Vector2()
var direction = 1

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = speed * delta * direction
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_needle_body_entered(body):
	if body.get_collision_layer_bit(0) == true:
		body.hitHope(position.x)
		queue_free()
	else:
		queue_free()

func set_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
