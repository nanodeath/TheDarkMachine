class_name Turret extends StaticBody2D

@export var bullet: PackedScene
@export var bullet_velocity: float = 100

@onready var gun: Node2D = $TurretBracket/Gun
@onready var animation_player = $AnimationPlayer
@onready var connectable_target = $ConnectableTarget

func _ready():
	connectable_target.activated.connect(self.shoot_burst)

func shoot_burst():
	animation_player.play("fire_burst")

func shoot():
	var bullet_instance := bullet.instantiate() as RigidBody2D
	bullet_instance.add_collision_exception_with(self)
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = global_position
	bullet_instance.global_rotation = gun.global_rotation
	var velocity_vector = Vector2.from_angle(gun.global_rotation) * bullet_velocity
	bullet_instance.linear_velocity = velocity_vector
