extends CanvasLayer
class_name Interface


var Dialog: PackedScene = preload('res://scene/management/dialog.tscn')


func _spawn_dialog(npc: StaticBody2D, dialog_text_list: Array) -> void:
  var dialog: Dialog = Dialog.instance()
  dialog.dialog_text_list = dialog_text_list
  var _dialog:bool = dialog.connect('dialog_finished', npc, 'on_dialog_finished')
  add_child(dialog)
