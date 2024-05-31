extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var money = 0
@export var cameraController : Node3D
@export var cameraLerpSpeed : float = .1
@export var camerTurnSpeed : float = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("movement_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_key_pressed(KEY_LEFT):
		rotate_y(deg_to_rad(camerTurnSpeed))
	elif Input.is_key_pressed(KEY_RIGHT):
		rotate_y(deg_to_rad(-camerTurnSpeed))
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("movement_left", "movement_right", "movement_up", "movement_down")
	input_dir.rotated(rotation.y)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	# Make CameraController match the position of myself
	cameraController.position = lerp(cameraController.position, position, cameraLerpSpeed)
	cameraController.rotation.y = rotation.y
	# $CameraController.position = lerp($CameraController.position, position, cameraLerpSpeed)

func addToMoney(amount):
	money += amount
	print(money)
