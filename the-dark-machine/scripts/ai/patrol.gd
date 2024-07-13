class_name Patrol extends Node

@export var move_right_initially: bool
@export var distance: float
@export var speed: float = 1
@export var pause_duration: float = 1
@onready var sprite = $"../Sprite"

func _ready():
	patrol()
		
func patrol():
	var tween := create_tween()
	tween.set_loops()
	var parent := get_parent()
	if move_right_initially:
		sprite.flip_h = false
		tween.tween_property(parent, "position", parent.global_position + Vector2(distance, 0), distance / speed)
		tween.tween_interval(pause_duration)
		tween.tween_callback(func(): sprite.flip_h = true)
		tween.tween_property(parent, "position", parent.global_position, distance / speed)
		tween.tween_interval(pause_duration)
		tween.tween_callback(func(): sprite.flip_h = false)
	else:
		sprite.flip_h = true
		tween.tween_property(parent, "position", parent.global_position - Vector2(distance, 0), distance / speed)
		tween.tween_interval(pause_duration)
		tween.tween_callback(func(): sprite.flip_h = false)
		tween.tween_property(parent, "position", parent.global_position, distance / speed)
		tween.tween_interval(pause_duration)
		tween.tween_callback(func(): sprite.flip_h = true)
