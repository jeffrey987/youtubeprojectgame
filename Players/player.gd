extends CharacterBody2D

var health=100
var gold=100
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# 添加播放动画
@onready var anim= get_node("AnimationPlayer")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY		
		anim.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	#判断左右移动是否反转
	if direction ==-1:		
		get_node("AnimatedSprite2D").flip_h=true
	elif direction ==1:	
		get_node("AnimatedSprite2D").flip_h=false
	#print("user input:",direction)
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	if velocity.y > 0:
		anim.play("Fall")

	move_and_slide()
