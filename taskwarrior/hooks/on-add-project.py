#!/usr/bin/env python3

import sys
import json

added_task = json.loads(sys.stdin.readline())
if added_task.get("project", "") == "":
    added_task["project"] = "default"
    # print("project required")
    # sys.exit(1)
result = json.dumps(added_task)
print(result)
print("added task to default project")
sys.exit(0)
