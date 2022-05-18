extends Area2D


# delete everything thar enters the area
func _on_DespawnArea_area_entered(area):
	area.get_parent().queue_free()
