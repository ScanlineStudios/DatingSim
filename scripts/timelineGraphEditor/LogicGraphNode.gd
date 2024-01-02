extends BasicGraphNode

class_name LogicGraphNode

enum Operation {
    NONE,
    AND,
    NOT,
    OR,
}

var operation = Operation.NONE


func get_class(): return "LogicGraphNode"
