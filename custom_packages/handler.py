import requests

def lambda_handler(event, context):
    response = requests.get('https://dog.ceo/api/breeds/list/all')
    return response.json()
