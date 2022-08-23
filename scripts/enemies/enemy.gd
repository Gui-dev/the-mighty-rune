extends KinematicBody2D
class_name Enemy

onready var attack_timer: Timer = $attack_cooldown
onready var sprite: Sprite = $texture
onready var animation: AnimationPlayer = $animation
var player_ref: KinematicBody2D = null
var velocity: Vector2
var can_deal_damage: bool = true
export(int) var enemy_damage
export(int) var health
export(int) var move_speed
export(int) var distance_threshold
export(float) var attack_cooldown


func _physics_process(_delta: float) -> void:
  if !player_ref:
    return
    
  _move()
  velocity = move_and_slide(velocity)
  verify_orientation()
  

func _move() -> void:
  var x_distance: float = player_ref.global_position.x - global_position.x
  var x_direction: float = sign(x_distance)
  
  if abs(x_distance) < distance_threshold and can_deal_damage:
    player_ref.update_health(enemy_damage)
    attack_timer.start(attack_cooldown)
    can_deal_damage = false
    velocity.x = 0
  
  if abs(x_distance) > distance_threshold:
    velocity.x = x_direction * move_speed  
  
 
func update_health(value: int) -> void:
  health -= value
  
  if health <= 0:
    queue_free() 
    return
    
  animation.play('hit')
 

func verify_orientation() -> void:
  if velocity.x > 0:
    sprite.flip_h = true
    
  if velocity.x < 0:
    sprite.flip_h = false
 

func _on_body_entered(body: Node) -> void:
  if body.is_in_group('player'):
    player_ref = body


func _on_body_exited(body: Node) -> void:
  if body.is_in_group('player'):
    player_ref = null


func _on_attack_cooldown_timeout() -> void:
  can_deal_damage = true


func _on_animation_finished(_anim_name: String) -> void:
  animation.play('idle')
  set_physics_process(true)
