import json
from utils import helper_function

def lambda_handler(event, context):
    name = event.get("name", "world")
    message = helper_function(name)
    return {
        "statusCode": 200,
        "body": json.dumps({"message": message})
    }