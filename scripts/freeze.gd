extends Node


func freeze_node(node, freeze):
	node.set_process(!freeze)
	node.set_physics_process(!freeze)
	node.set_process_input(!freeze)
	node.set_process_internal(!freeze)
	node.set_process_unhandled_input(!freeze)
	node.set_process_unhandled_key_input(!freeze)

func freeze_scene(node, freeze):
	freeze_node(node, freeze)
	for c in node.get_children():
		freeze_scene(c, freeze)
