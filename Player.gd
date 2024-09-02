extends CharacterBody3D

var speed = 5
var gravity = 9.8
var jump_impulse = 4.9
var sensitivity = 0.2
var v = Vector3.ZERO
var yaw = 0
var pitch = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * sensitivity
		pitch -= event.relative.y * sensitivity
		pitch = clamp(pitch, -90, 90)
		$Model.rotation_degrees.y = yaw
		$Model/CameraContainer/Camera3D.rotation_degrees.x = pitch
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _physics_process(dt):
	var d = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		d.z += 1
	if Input.is_action_pressed("move_back"):
		d.z -= 1
	if Input.is_action_pressed("move_left"):
		d.x += 1
	if Input.is_action_pressed("move_right"):
		d.x -= 1
	if d != Vector3.ZERO:
		d = d.normalized()
		d = $Model.transform.basis.z * d.z + $Model.transform.basis.x * d.x
	v.x = d.x * speed
	v.z = d.z * speed
	if not is_on_floor():
		v.y -= gravity * dt
	else:
		v.y = 0
	if is_on_floor() and Input.is_action_pressed("jump"):
		v.y = jump_impulse
	self.velocity = v
	self.move_and_slide()
