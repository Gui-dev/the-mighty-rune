extends Area2D
class_name Arrow


var direction: float = 1.0
export(int)var speed = 180
onready var sprite: Sprite = get_node('texture')
onready var animation: AnimationPlayer = get_node('animation')


func _ready() -> void:
  if direction == -1.0:
    sprite.flip_h = true
    
func _physics_process(delta: float) -> void:
  translate(Vector2(delta * direction * speed, 0))


func _on_body_entered(body: Node) -> void:
  if body is TileMap:
    animation.play('stuck')
    set_physics_process(false)


func _on_animation_finished(_anim_name: String) -> void:
  queue_free()


func _on_notifier_screen_exited() -> void:
  queue_free()
