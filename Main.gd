extends Node


var Note: PackedScene = preload("res://Note.tscn")


func _unhandled_input(event):

    if event is InputEventScreenTouch or event is InputEventScreenDrag:

        var note: Node
        var n: String = "Note_" + str(event.get_index())
        if has_node(n):
            note = get_node(n)
        else:
            note = Note.instantiate()
            note.set_name(n)
            add_child(note)

        var pos: Vector2 = event.get_position()
        pos -= get_viewport().get_visible_rect().get_center()

        var angle: float = -pos.angle_to(Vector2.LEFT)

        angle = (2 * snappedf(angle, TAU/12.) + angle)/3
        note.get_node("Line2D").set_rotation(angle)

        var pitch: float = pow(2, fmod(angle/TAU, 1))
        note.get_node("AudioStreamPlayer").set_pitch_scale(pitch)

        if event is InputEventScreenTouch:
            if event.is_pressed():
                note.get_node("AnimationPlayer").play("note_on")
            else:
                note.get_node("AnimationPlayer").play("note_off")
                note.set_name(str(note.get_instance_id()))
