extends Node2D

@onready var obstaclePrefab = preload("res://scenes/prefabs/obstaclePrefab.tscn")

@export var hSpawnRange:Vector2 = Vector2(0,100)
@export var vSpawnRange:Vector2 = Vector2(0,100)
@export var startingObstacleSpeed = 100

var dinosaurActive = false
var obstaclesMade:int = 0
var maxRandWaitTime: int = 129

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func StartGame() -> void:
	dinosaurActive = true
	RandomSpawn()
	
	
func RandomSpawn() -> void:
	while dinosaurActive:
		var waitTime:float = randf_range(0,maxRandWaitTime) / 8
		await get_tree().create_timer(waitTime).timeout
		InstantiateObstacle()

func FixedSpawn() -> void:
	InstantiateObstacle()
	
func InstantiateObstacle() -> void:
	obstaclesMade = obstaclesMade + 1
	var obstacleSpeed:float = startingObstacleSpeed
	if get_tree().get_first_node_in_group("scoreCard"): 
		obstacleSpeed += ( get_tree().get_first_node_in_group("scoreCard").score / 8 )
	if obstaclesMade % 5 == 0 and maxRandWaitTime != 1: maxRandWaitTime = maxRandWaitTime - 8
	var newObstacle:Node2D = obstaclePrefab.instantiate()
	get_parent().add_child.call_deferred(newObstacle)
	var entryDir:int = randi_range(0,2)
	match entryDir:
		0: 
			newObstacle.global_position = Vector2(-100, randf_range(hSpawnRange.x, hSpawnRange.y))
			newObstacle.initialVel = Vector2(1, 0) * obstacleSpeed
		1:
			newObstacle.global_position = Vector2(1200, randf_range(hSpawnRange.x, hSpawnRange.y))
			newObstacle.initialVel = Vector2(-1, 0) * obstacleSpeed
		2:
			newObstacle.global_position = Vector2(randf_range(vSpawnRange.x, vSpawnRange.y), -100)
			newObstacle.initialVel = Vector2(0, 1) * obstacleSpeed
