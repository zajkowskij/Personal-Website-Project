class_name Drawer extends Node

var drawerDimensions:Vector2
var parent
var isDrawerOpen:bool = false
@export var itemsInDrawer:Array[PackedScene]

enum drawerDirections {HORIZONTAL_LEFT, HORIZONTAL_RIGHT, VERTICAL}
@export var drawerDirection:drawerDirections = drawerDirections.VERTICAL

func _ready():
	drawerDimensions = get_parent().get_node("DrawerArea").size
	parent = get_parent()
	print(drawerDimensions)
	for item in itemsInDrawer:
		var i = item.instantiate()
		get_parent().add_child.call_deferred(i)
		match drawerDirection:
			drawerDirections.VERTICAL:
				i.position.y = -randf_range(100, drawerDimensions.y-100)
				i.position.x = randf_range((-drawerDimensions.x / 2)+40, (drawerDimensions.x / 2)-40)
			drawerDirections.HORIZONTAL_LEFT:
				i.position.y = randf_range(-drawerDimensions.y / 2 + 40, drawerDimensions.y / 2 - 40)
				i.position.x = randf_range(-drawerDimensions.x + 100, -100)
			drawerDirections.HORIZONTAL_RIGHT:
				i.position.y = randf_range(-drawerDimensions.y / 2 + 40, drawerDimensions.y / 2 - 40)
				i.position.x = randf_range(drawerDimensions.x - 100, 100)


func OnDrawerButtonPressed():
	Audio_Manager.CreateAudio(SoundEffect.SoundEffectType.DRAWER_OPEN)
	match drawerDirection:
		drawerDirections.VERTICAL:
			MoveDrawer(parent.position.x, parent.position.y, 0, 400)
		drawerDirections.HORIZONTAL_LEFT:
			MoveDrawer(parent.position.x, parent.position.y, 400, 0)
		drawerDirections.HORIZONTAL_RIGHT:
			MoveDrawer(parent.position.x, parent.position.y, -400, 0)

func MoveDrawer(x:float, y:float, a:float, b:float):
	var tween = get_tree().create_tween()
	if isDrawerOpen:
		tween.tween_property(parent, "position", Vector2(x - a,y - b), 0.35).set_trans(Tween.TRANS_SPRING)
	else:
		tween.tween_property(parent, "position", Vector2(x + a, y + b), 0.35).set_trans(Tween.TRANS_SPRING)
	isDrawerOpen = !isDrawerOpen
