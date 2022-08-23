extends Sprite
class_name PlayerTexture


var on_action: bool = false
onready var spawn_arrow: Position2D = get_node('%spawn_arrow')
onready var animation: AnimationPlayer = get_node('%animation')
onready var player: KinematicBody2D = get_parent()


func _animated(velocity: Vector2) -> void:
  _verify_orientation(velocity.x)
  
  if on_action:
    return
  
  if velocity.y != 0:
    _vertical_behavior(velocity.y)
    return
  
  _horizontal_behavior(velocity.x)
 

func action_bahavior(action: String) -> void:
  on_action = true
  animation.play(action)
   

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
    spawn_arrow.position = Vector2(9, 6)
    
  if speed < 0:
    flip_h = true
    spawn_arrow.position = Vector2(-9, 6)


func _on_animation_finished(anim_name: String) -> void:
  if anim_name == 'attack':
    on_action = false
    player.can_attack = true
    player.set_physics_process(true)
    
  if anim_name == 'hit':
    on_action = false
    player.can_attack = true
    player.set_physics_process(true)
