extends RigidBody2D

@export var initialVel:Vector2 = Vector2(10.0, 10.0)
@export var randomizeDirection:bool = false

var currentVel:Vector2

@onready var sprite:Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(OnCollide)
	contact_monitor = true
	max_contacts_reported = 4
	var random = randi_range(0,1)
	if randomizeDirection:
		if random == 0: initialVel.x = -initialVel.x
		else: pass
		random = randi_range(0, 1)
		if random == 0: initialVel.y = -initialVel.y
		else: pass
	linear_velocity = initialVel
	currentVel = linear_velocity

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	state.linear_velocity = currentVel
	
func OnCollide(body:Node):
	print(get_colliding_bodies())
	print(get_contact_count())
	Audio_Manager.CreateAudio(SoundEffect.SoundEffectType.COWBELL)
	sprite.modulate = Color(randf_range(0,1), randf_range(0,1), randf_range(0,1))
	if get_contact_count() == 2:
		match body.name:
			"StaticBody2D": currentVel = Vector2(currentVel.x, -currentVel.y)
			"StaticBody2D2": currentVel = Vector2(currentVel.x, -currentVel.y)
			"StaticBody2D3": currentVel = Vector2(-currentVel.x, currentVel.y)
			"StaticBody2D4": currentVel = Vector2(-currentVel.x, currentVel.y)
	elif get_contact_count() > 2: 
		Audio_Manager.CreateAudio(SoundEffect.SoundEffectType.CORNER_HIT)
		if get_tree().get_first_node_in_group("scoreCard"):
			get_tree().get_first_node_in_group("scoreCard").AddScore(500)
		print("CORNER!!!")
		queue_free()
