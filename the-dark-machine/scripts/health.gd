class_name Health extends Node

@export var health: int = 1

signal died

var dead := false

func damage(amount: int):
	health -= amount
	if health <= 0 and not dead:
		dead = true
		emit_signal("died")
