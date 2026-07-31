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

# Create company
r = requests.post(f'{BASE_URL}/companies',
    json={'name': 'Test', 'slug': 'test', 'industry': 'Tech'},
    headers={'Authorization': f'Bearer {token}', **HEADERS})
company_id = r.json().get('id')

# Try create job
r = requests.post(f'{BASE_URL}/jobs',
    json={'title': 'Test Job', 'companyId': company_id, 'description': 'Test'},
    headers={'Authorization': f'Bearer {token}', **HEADERS})
print(f'Jobs POST: {r.status_code}')
print(f'Response: {r.text[:300]}')
