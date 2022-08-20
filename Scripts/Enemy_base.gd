extends Area2D

var hp = 10
	

func take_damage(amount):
	hp -= amount
	print(hp)
	if hp == 0:
		queue_free()



func _on_Enemy_base_area_entered(area):
	print(area, 'vei da base')
	if area.is_in_group('player_mob'):
		print(area)
		#take_damage(area.damage)
