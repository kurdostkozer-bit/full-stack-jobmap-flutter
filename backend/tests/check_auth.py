import requests
import uuid

r = requests.post("http://localhost:3000/api/v1/auth/register",
    json={"email": f"test-{uuid.uuid4().hex[:4]}@test.com", "password": "TestPass123"},
    headers={"Content-Type": "application/json"})

print(f"Status: {r.status_code}")
print(f"Response: {r.json()}")
