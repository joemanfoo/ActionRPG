extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
var velocity = Vector2.ZERO
var movement_speed = 1

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = movement_speed * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input_vector.y = movement_speed * (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set('parameters/Idle/blend_position', input_vector)
		animationTree.set('parameters/Run/blend_position', input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
	
	velocity = move_and_slide(velocity)
