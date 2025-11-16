extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	var tween:Tween = create_tween()
	tween.tween_property(self, "color", Color.WHITE, 3.0)
	await get_tree().create_timer(3.0).timeout
	tween.stop()
	tween.tween_property(self, "color", Color(0,0,0,0), 0.5)
	tween.play()
	await get_tree().create_timer(0.5).timeout
