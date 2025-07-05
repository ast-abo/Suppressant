extends CharacterBody3D

@onready var Marker = $Marker

@export var speed = 5.0

var target_velocity = Vector3.ZERO
@export var fall_acceleration = 75

const mouse_sens = 0.3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x + mouse_sens))
		Marker.rotate_x(-deg_to_rad(event.relative.y + mouse_sens))
		Marker.rotation.x = clamp(Marker.rotation.x, deg_to_rad(-89), deg_to_rad(89)) 

func _physics_process(delta):
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed
	else:
		target_velocity.x = move_toward(velocity.x, 0, speed)
		target_velocity.z = move_toward(velocity.z, 0, speed)

	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	velocity = target_velocity
	move_and_slide()
