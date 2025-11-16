extends CharacterBody2D

@export var initialVel = Vector2(0, 100)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	velocity = initialVel
	move_and_slide()
	
	if global_position.x > 1500 or global_position.x < -500: queue_free()
	if global_position.y > 1000 or global_position.y < -500: queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.is_in_group("dinosaur"):
		body.KillDinosaur()
	
