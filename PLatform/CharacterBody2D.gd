extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var attacking = false
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("ui_accept"):
		attacking = true
		animated_sprite.play("attack")
		print("attack")

	var direction = Input.get_axis("ui_left", "ui_right") 
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction > 0
		if attacking == false:
			animated_sprite.play("walk")
		attacking = false
	elif velocity.x == 0 and not attacking:
		animated_sprite.play("idle")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.stop()
	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "attack":
		print("Test")

