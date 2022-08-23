extends KinematicBody2D
class_name Player

var Arrow: PackedScene = preload('res://scene/character/arrow.tscn')
var velocity: Vector2
var can_attack: bool = true
onready var animation: AnimationPlayer = $animation
onready var sprite: Sprite = get_node('texture')
onready var spawn_arrow: Position2D = get_node('spawn_arrow')
export(int) var health
export(int) var move_speed
export(int) var jump_speed
export(int) var gravity_speed


func _physics_process(delta: float) -> void:
  _move()
  _attack()
  _jump(delta)
  velocity = move_and_slide(velocity, Vector2.UP)
  sprite._animated(velocity)


func _move() -> void:
  velocity.x = move_speed * _get_direction()
  

func _get_direction() -> float:
  return Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')


func _attack() -> void:
  if Input.is_action_just_pressed('ui_attack') and is_on_floor() and can_attack:
    can_attack = false
    sprite.action_bahavior('attack')


func _jump(delta: float) -> void:
  velocity.y += delta * gravity_speed
  var jump_button = Input.is_action_just_pressed('ui_select')
  
  if jump_button and is_on_floor():
    velocity.y = -jump_speed


func spawn_project() -> void:
  var arrow: Arrow = Arrow.instance()
  arrow.global_position = spawn_arrow.global_position
  arrow.direction = sign(spawn_arrow.position.x)
  get_tree().root.call_deferred('add_child', arrow)


func freeze(state: bool) -> void:
  animation.play('idle')
  set_physics_process(state)


func update_health(value: int) -> void:
  health -= value
    
  if health <= 0:
    var _change_scene: bool = get_tree().change_scene("res://scene/management/game_level.tscn")
    return
    
  sprite.action_bahavior('hit')
