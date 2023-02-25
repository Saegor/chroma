extends Node


var Note: PackedScene = load("res://Note.tscn")


func _unhandled_input(event):

    if event is InputEventScreenTouch or event is InputEventScreenDrag:

        var note_name: String = "NOTE_" + str(event.get_index())
        var note: Node
        if has_node(note_name):
            note = get_node(note_name)
        else:
            note = Note.instantiate()
            note.set_name(note_name)
            add_child(note)

        var pos: Vector2 = event.get_position()
        pos -= get_viewport().get_visible_rect().get_center()

        var angle: float = -pos.angle_to(Vector2.LEFT)

<<<<<<< HEAD
        angle = (2 * snappedf(angle, TAU/12.) + angle)/3
=======
        angle = (snappedf(angle, TAU/12.) + angle)/2
>>>>>>> 14be6a5 (Update)
        note.get_node("Line2D").set_rotation(angle)

        var pitch: float = pow(2, fmod(angle/TAU, 1))
        note.get_node("AudioStreamPlayer").set_pitch_scale(pitch)

        if event is InputEventScreenTouch:
            if event.is_pressed():
                note.get_node("AnimationPlayer").play("note_on")
            else:
                note.get_node("AnimationPlayer").play("note_off")
