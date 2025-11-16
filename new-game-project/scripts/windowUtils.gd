class_name WindowUtils extends Node

var tree

func _ready() -> void:
	tree = get_tree()

func MouseEnterHighlight() -> void:
	var affectedNode:Control = get_parent()
	var tween = tree.create_tween()
	tween.tween_property(affectedNode, "self_modulate", Color("ffffff"), 0.2)
	
func MouseExitHighlight() -> void:
	var affectedNode:Control = get_parent()
	var tween = tree.create_tween()
	tween.tween_property(affectedNode, "self_modulate", Color("c7c7c7"), 0.2)
