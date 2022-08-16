extends StaticBody2D


export var base_life:int = 100

func _process(_delta):
	$TextureProgress.value = base_life

func take_damage(dano):
	base_life -= dano
