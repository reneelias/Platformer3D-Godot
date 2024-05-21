extends Area3D

const SPIN_SPEED = 1 # number of degrees coin rotates every fram
signal coin_collected(int)
@export var coin_value : int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect("coin_collected", Callable(get_tree().get("Player"), "addToMoney"))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_spin()


func _spin():
	rotate_y(deg_to_rad(SPIN_SPEED))



func _on_body_entered(body:Node3D):
	if body.name == "Player":
		# coin_collected.emit(coin_value)
		body.addToMoney(coin_value)
		queue_free()
