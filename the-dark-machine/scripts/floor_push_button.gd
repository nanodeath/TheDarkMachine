class_name FloorPushButton extends Area2D

@onready var animated_sprite = $AnimatedSprite
@onready var connectable_source = $ConnectableSource

signal button_pushed

var touch_count := 0

func _ready():
	body_entered.connect(self._body_entered)
	body_exited.connect(self._body_exited)
	
	connectable_source.connection_established.connect(self._link_to_target)

func _body_entered(body: Node2D):
	touch_count += 1
	if touch_count == 1:
		animated_sprite.play("pushed")
		emit_signal("button_pushed")
	
func _body_exited(body: Node2D):
	touch_count -= 1
	if touch_count == 0:
		animated_sprite.play("default")

func _link_to_target(target: ConnectableTarget):
	button_pushed.connect(target.activate)
	pass
	
