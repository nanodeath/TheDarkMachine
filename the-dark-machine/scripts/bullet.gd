class_name Bullet extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("bullet hit ", body)
	var health := body.get_node_or_null("Health") as Health
	if health:
		health.damage(1)
	queue_free()
