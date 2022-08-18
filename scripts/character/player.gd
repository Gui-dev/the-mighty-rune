extends KinematicBody2D
class_name Player


onready var sprite: Sprite = get_node('texture')
var velocity: Vector2
export(int) var move_speed
export(int) var jump_speed
export(int) var gravity_speed


func _physics_process(delta: float) -> void:
  _move()
  _jump(delta)
  velocity = move_and_slide(velocity, Vector2.UP)
  sprite._animated(velocity)


func _move() -> void:
  velocity.x = move_speed * _get_direction()
  

func _get_direction() -> float:
  return Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')


func _jump(delta: float) -> void:
  velocity.y += delta * gravity_speed
  var jump_button = Input.is_action_just_pressed('ui_select')
  
  if jump_button and is_on_floor():
    velocity.y = -jump_speed



