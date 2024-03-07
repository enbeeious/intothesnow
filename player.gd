extends CharacterBody3D

@onready var pcamera = $pcamera

var camera_rotation = Vector3()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera_rotation.x -= event.relative.y / 360
		camera_rotation.y -= event.relative.x / 360

func _physics_process(delta):
	
	pcamera.rotation = camera_rotation
	var axis_movement = Vector2(Input.get_axis("A", "D"), Input.get_axis("W", "S")).normalized()
	var axis_movement_rotated = axis_movement.rotated(-pcamera.rotation.y)
	
	velocity = lerp(velocity, Vector3(axis_movement_rotated.x * 4, velocity.y, axis_movement_rotated.y * 4), 0.2)
	velocity.y -= 0.17
	if Input.is_action_just_pressed("SPACE") and is_on_floor():
		velocity.y = 4
	
	move_and_slide()
