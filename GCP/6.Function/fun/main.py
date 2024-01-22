import functions_framework
import requests

@functions_framework.http
def hello_http(request):
    """HTTP Cloud Function to get address info using Nominatim API.
    Args:
        request (flask.Request): The request object.
    Returns:
        Information about the provided address.
    """
    # Get the address from the request
    request_json = request.get_json(silent=True)
    request_args = request.args

    if request_json and 'address' in request_json:
        address = request_json['address']
    elif request_args and 'address' in request_args:
        address = request_args['address']
    else:
        return 'No address provided.'

    # Call the Nominatim API
    try:
        api_url = "https://nominatim.openstreetmap.org/search"
        params = {
            "q": address,
            "format": "json"
        }
        response = requests.get(api_url, params=params)
        response.raise_for_status()  # Raises an HTTPError if the HTTP request returned an unsuccessful status code

        # Return the API response
        return response.json()
    except requests.RequestException as e:
        return f"An error occurred: {e}"
