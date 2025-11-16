extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var funStuff:Array[Node] = get_tree().get_nodes_in_group("funStuff")
	print(funStuff)
	
	for item in funStuff:
		item.queue_free()
		
	if get_tree().get_first_node_in_group("scoreCard"):
		var scoreCard = get_tree().get_first_node_in_group("scoreCard")
		scoreCard.Reset()
		scoreCard.Deactivate()
		scoreCard.Disappear()
		var obstacleManager = get_tree().get_first_node_in_group("obstacleManager")
		obstacleManager.dinosaurActive = false
		obstacleManager.maxRandWaitTime = 129
	
	Audio_Manager.CreateAudio(SoundEffect.SoundEffectType.CLAP)
	queue_free()
