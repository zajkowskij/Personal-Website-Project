class_name Drawer_DropArea extends DropArea

func _drop_data(at_position, data):
	print("dropping data into drawer")
	print(at_position)
	data.reparent(self)
	data.position = at_position
	data.ReturnIcon()
