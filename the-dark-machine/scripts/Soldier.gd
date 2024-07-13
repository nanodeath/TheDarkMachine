class_name Soldier extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var sprite_dead: AnimatedSprite2D = $SpriteDead
@onready var ai_patrol = $AiPatrol
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

signal died

func die():
	emit_signal("died")
	sprite.visible = false
	sprite_dead.visible = true
	ai_patrol.queue_free()
	collision_shape_2d.disabled = true
