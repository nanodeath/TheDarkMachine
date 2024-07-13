class_name Wire extends Node2D

var source: ConnectableSource
var target: ConnectableTarget
@onready var line = $Line2D
@onready var sprite = $Sprite
@onready var collision_shape_2d: CollisionShape2D = $ClickTarget/CollisionShape2D
var clickable_rect: RectangleShape2D

func _ready():
	clickable_rect = collision_shape_2d.shape.duplicate()
	collision_shape_2d.shape = clickable_rect
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2.ZERO)

func _process(delta):
	var p1: Vector2
	var p2: Vector2
	var show_sprite := true
	if source and target:
		if !is_instance_valid(source) || !is_instance_valid(target):
			# TODO need to disconnect at appropriate time
			queue_free()
			return
		p1 = source.global_position
		p2 = target.global_position
		var length := p1.distance_to(p2)
		var shape_scale := collision_shape_2d.global_scale.x
		show_sprite = false
		
		clickable_rect.size.x = length * shape_scale
		collision_shape_2d.global_position = (p1 + p2)/2
		collision_shape_2d.global_rotation = p1.angle_to_point(p2)
	elif source or target:
		if source:
			p1 = source.global_position
		else:
			p1 = target.global_position
		p2 = get_global_mouse_position()
	
	if p1 and p2:
		line.set_point_position(0, to_local(p1))
		line.set_point_position(1, to_local(p2))
	sprite.visible = show_sprite

## returns true if done connecting, false otherwise
func equipment_connect(global_position: Vector2, user_placed: UserPlaced) -> bool:
	process_mode = Node.PROCESS_MODE_INHERIT
	var space_state := get_world_2d().direct_space_state
	var query_params := PhysicsPointQueryParameters2D.new()
	query_params.collide_with_areas = true
	query_params.position = global_position
	var collisions := space_state.intersect_point(query_params)
	for c in collisions:
		var collider := c["collider"] as Node
		if collider.get_parent() is PhysicsBody2D or collider.get_parent() is Area2D:
			collider = collider.get_parent()
		
		var connectable_source := collider.get_node_or_null("ConnectableSource") as ConnectableSource
		if connectable_source and connectable_source.wire_compatible:
			print("Can connect source to: ", connectable_source)
			source = connectable_source
			reparent(source)
			break
		
		var connectable_target := collider.get_node_or_null("ConnectableTarget") as ConnectableTarget
		if connectable_target and connectable_target.wire_compatible:
			print("Can connect target to: ", connectable_target)
			target = connectable_target
			break
	
	if source and target:
		source.connect_to(target)
		add_child(user_placed)
		# Release the wire
		var disconnected = false
		source.tree_exiting.connect(func():
			if not disconnected and user_placed:
				disconnected = true
				user_placed.return_equipment()
			)
		target.tree_exiting.connect(func():
			if not disconnected and user_placed:
				disconnected = true
				user_placed.return_equipment()
			)
		return true
	return false
