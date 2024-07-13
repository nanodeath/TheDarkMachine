class_name Solider extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("walk_left")
	animation_player.animation_finished.connect(self._animation_finished)

func _animation_finished(anim_name: StringName):
	# print("Done! " + str(anim_name))
	if anim_name == 'walk_left':
		animation_player.play("walk_right")
	else:
		animation_player.play("walk_left")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
