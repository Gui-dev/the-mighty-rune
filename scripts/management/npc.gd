extends StaticBody2D
class_name Npc


onready var quest_mark: Sprite = $quest_mask 
var can_interact: bool = false
var player_ref: KinematicBody2D = null
export(Array, String) var dialog_text


func _physics_process(_delta: float) -> void:
  if Input.is_action_just_pressed('ui_interact') and can_interact:
    can_interact = false
    player_ref.freeze(false)
    get_tree().call_group('interface', '_spawn_dialog', self, dialog_text)


func _on_body_entered(body: Node) -> void:
  if body is Player:
    player_ref = body
    can_interact = true
    quest_mark.visible = true


func _on_body_exited(body: Node) -> void:
  if body is Player:
    can_interact = false
    player_ref = null
    quest_mark.visible = false


func on_dialog_finished() -> void:
  can_interact = true
  player_ref.freeze(true)
