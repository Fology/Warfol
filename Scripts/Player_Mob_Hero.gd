extends Path2D

var current_state := 0
var current_animation : int = 0
var can_animate :bool = true
export var velocity = 100
export var life = 20
enum {IDLE, RUN, ATTACK}
var can_run = true
var can_attack = false

#var enemies = get_tree().get_nodes_in_group('enemy_mob')
func _ready():
	#print(enemies)
	pass

func _process(delta):
	$PathFollow2D/Player_Mob_1/TextureProgress.value = life
	match current_state:
		IDLE:
			idle_state(delta)
		RUN:
			run_state(delta)
		ATTACK:
			attack_state()

#Actions
func take_damage(dano):
	life -= dano
	
#Check Functions	
func _check_run_state():
	var new_state = current_state
	if can_run == false:
		new_state = IDLE
	return new_state
	
func _check_idle_state():
	var new_state = current_state
	if can_run:
		new_state = RUN
	if can_attack:
		new_state = ATTACK
	return new_state

func _check_attack_state():
	var new_state = current_state
	if can_attack == false:
		new_state = IDLE
	return new_state
	
#State Functions
func run_state(_delta):
	$PathFollow2D/Player_Mob_1/AnimatedSprite.play("Rum")
	_move(_delta)
	current_state = _check_run_state()
	
func idle_state(_delta):
	$PathFollow2D/Player_Mob_1/AnimatedSprite.play("Idle")
	current_state = _check_idle_state()

func attack_state():
	_combo_attack()
	current_state = _check_attack_state()
	yield(get_node("PathFollow2D/Player_Mob_1/AnimatedSprite"), "animation_finished")
	
#Helpers
func _move(_delta):
	$PathFollow2D.offset += velocity * _delta
	
func _combo_attack():
	$PathFollow2D/Player_Mob_1/AnimatedSprite.play("Attack")
	
func _on_Player_Mob_Hero_body_entered(body):
	if body.is_in_group('player_mob'):
		can_run = false
		
	if body.is_in_group('enemy_mob'):
		can_attack = true
		can_run = false
	
func _on_Player_Mob_Hero_body_exited(_body):
	can_run = true
	can_attack = false
