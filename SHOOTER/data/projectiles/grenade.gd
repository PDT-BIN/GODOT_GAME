extends RigidBody2D


# MOVEMENT.
const SPEED: int = 750
# EXPLOSION.
var is_exploded: bool = false
const EXPLOSION_RADIUS: int = 350


func explode():
	$AnimationPlayer.play("Explosion")
	is_exploded = true


func _process(_delta):
	if is_exploded:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var is_in_range = target.global_position.distance_to(global_position) < EXPLOSION_RADIUS
			if "hit" in target and is_in_range:
				target.hit()
