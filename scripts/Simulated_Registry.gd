extends Node


var registry = {"Test": "*this*",
                "Time": str(OS.get_datetime(false)),
                "SYSTEM": OS.get_name() }

# Public Methods

func lookup(name : String):
    if registry.has(name):
        return registry[name]
    else:
        return ""
