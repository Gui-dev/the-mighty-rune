extends Sprite
class_name PlayerTexture


onready var animation: AnimationPlayer = get_node('%animation')


func _animated(velocity: Vector2) -> void:
  _verify_orientation(velocity.x)
  if velocity.y != 0:
    _vertical_behavior(velocity.y)
    return
  
  _horizontal_behavior(velocity.x)
    

func _vertical_behavior(speed: float) -> void:
  if speed > 0:
    animation.play('fall')
  
  if speed < 0:
    animation.play('jump')
    

func _horizontal_behavior(speed: float) -> void:
  if speed != 0:
    animation.play('run')
    return
  
  animation.play('idle')


func _verify_orientation(speed: float) -> void:
  if speed > 0:
    flip_h = false
    
  if speed < 0:
    flip_h = true
