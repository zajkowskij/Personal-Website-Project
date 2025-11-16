extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animatedSprite:AnimatedSprite2D = $Sprite2D
@onready var coll: CollisionShape2D = $CollisionShape2D
@onready var deadDino:PackedScene = preload("res://scenes/prefabs/dead_dinosaur.tscn")

var scoreCard = null

func _ready() -> void:
	if get_tree().get_first_node_in_group("scoreCard"):
		scoreCard = get_tree().get_first_node_in_group("scoreCard")
		if !scoreCard.running: 
			scoreCard.Activate()
			get_tree().get_first_node_in_group("obstacleManager").StartGame()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("dino_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("dino_left", "dino_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	HandleAnimations(direction)

	move_and_slide()

func HandleAnimations(direction:float):
	
	if !Input.is_action_pressed("dino_down"):
		if coll.shape.get_size().y == 8:
			coll.shape.set_size(Vector2(coll.shape.get_size().x, 16))
			coll.position = Vector2(coll.position.x, 16)
			print("uncrouch")
		
		
		if Input.is_action_just_pressed("dino_jump") and is_on_floor():
			animatedSprite.play("idle")
			Audio_Manager.CreateAudio(SoundEffect.SoundEffectType.COWBELL)
		
		if is_on_floor() and direction == 0:
			animatedSprite.play("idle")
		else: animatedSprite.play("walk")
	
	elif Input.is_action_pressed("dino_down"):
		if coll.shape.get_size().y == 16:
			coll.shape.set_size(Vector2(coll.shape.get_size().x, 8))
			coll.position = Vector2(coll.position.x, 24)
			animatedSprite.position = Vector2(animatedSprite.position.x, 0)
			print("crouch")
		
		if direction == 0: 
			animatedSprite.play("crouch")
			animatedSprite.pause()
		else: animatedSprite.play("crouch")
	
	if direction < 0 and !animatedSprite.flip_h: 
		animatedSprite.flip_h = true
		animatedSprite.position = Vector2(-15.5, animatedSprite.position.y)
	elif direction > 0 and animatedSprite.flip_h: 
		animatedSprite.flip_h = false
		animatedSprite.position = Vector2(15.5, animatedSprite.position.y)

func KillDinosaur():
	if get_tree().get_node_count_in_group("dinosaur") == 1:
		scoreCard.Deactivate()
		get_tree().get_first_node_in_group("obstacleManager").dinosaurActive = false
	else:
		scoreCard.Reset()
	var gravestone:Node2D = deadDino.instantiate()
	get_parent().add_child(gravestone)
	gravestone.global_position = global_position
	if animatedSprite.flip_h: gravestone.get_node("Sprite2D").flip_h = true
	else: gravestone.get_node("Sprite2D").flip_h = false
	queue_free()
