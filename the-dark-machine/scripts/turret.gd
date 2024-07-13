class_name Turret extends Sprite2D

@export var bullet: PackedScene
@onready var gun: Node2D = $Gun
@export var bullet_velocity: float = 100
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("fire_burst")
	pass

func shoot():
	var bullet_instance := bullet.instantiate() as RigidBody2D
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = global_position
	bullet_instance.global_rotation = gun.global_rotation
	var velocity_vector = Vector2.from_angle(gun.global_rotation) * bullet_velocity
	bullet_instance.linear_velocity = velocity_vector

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	pass
