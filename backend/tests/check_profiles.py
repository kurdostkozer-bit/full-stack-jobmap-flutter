#!/usr/bin/env python3
import requests
import uuid

BASE_URL = 'http://localhost:3000/api/v1'
HEADERS = {'Content-Type': 'application/json'}

# Register user
r = requests.post(f'{BASE_URL}/auth/register',
    json={'email': f'test-{uuid.uuid4().hex[:4]}@test.com', 'password': 'Test@123'},
    headers=HEADERS)
token = r.json().get('accessToken')
print(f'Auth: {r.status_code}')

# Create career profile
r = requests.post(f'{BASE_URL}/career-profiles',
    json={'title': 'Profile A', 'bio': 'Bio A', 'skills': ['Skill1']},
    headers={'Authorization': f'Bearer {token}', **HEADERS})
print(f'Career Profile POST: {r.status_code}')
print(f'Response: {r.text[:300]}')
