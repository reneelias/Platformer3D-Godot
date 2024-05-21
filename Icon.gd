extends Sprite3D

var coins = 5
var playerName = "robot"
@export var rotationSpeed = 1.0
var keyCollected = false
var angularVelocity = 0
@export var angularAcceleration = .01


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	InputRotation()
	# print(Engine.get_frames_per_second())

func InputRotation():
	if Input.is_key_pressed(KEY_LEFT):
		angularVelocity += angularAcceleration
	elif Input.is_key_pressed(KEY_RIGHT):
		angularVelocity -= angularAcceleration
	elif angularVelocity != 0:
		angularVelocity = move_toward(angularVelocity, 0, angularAcceleration)
	rotate_y(deg_to_rad(angularVelocity))