extends RigidBody3D

@onready var pcamera = $pcamera

var camera_rotation = Vector3()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera_rotation.x -= event.relative.y / 360
		camera_rotation.y -= event.relative.x / 360

func _integrate_forces(state):
	
	pcamera.rotation = camera_rotation
	var axis_movement = Vector2(Input.get_axis("A", "D"), Input.get_axis("W", "S")).normalized()
	var axis_movement_rotated = axis_movement.rotated(-pcamera.rotation.y)
	var move_speed_multiplier = 64 * (1-clamp(Vector2(linear_velocity.x, linear_velocity.z).length(), 0, 1))
	
	apply_central_force(Vector3(axis_movement_rotated.x, 0, axis_movement_rotated.y) * 16) 
