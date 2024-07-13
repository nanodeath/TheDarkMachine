class_name DaysSinceLastAccident extends Node2D

@export var initial_value: int = 1
@onready var counter = $Sign/HBoxContainer/Panel/Counter

func _ready():
	counter.text = str(initial_value)

func reset_counter():
	counter.text = str(0)
	counter.add_theme_color_override("default_color", Color.RED)
