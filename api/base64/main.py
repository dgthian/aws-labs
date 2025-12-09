import base64
encoded = base64.b64encode(b'Send reinforcements')
print(encoded)  # Output:

data = base64.b64decode(encoded)
print(data)  # Output: b'data to be encoded'