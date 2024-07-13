class_name Cloud extends Sprite2D

@export var speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x += speed * delta
	var screen_width := get_window().size.x
	var cloud_width := texture.get_width() * global_scale.x
	if speed > 0 && global_position.x > screen_width:
		global_position.x = -cloud_width
	elif speed < 0 && global_position.x < -cloud_width:
		global_position.x = screen_width
