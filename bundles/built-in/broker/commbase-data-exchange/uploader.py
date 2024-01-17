#!/usr/bin/env python
################################################################################
#                            commbase-data-exchange                            #
#                                                                              #
# Server for exchanging data with clients over HTTP and WebSocket connections  #
#                                                                              #
# Change History                                                               #
# 01/17/2024  Esteban Herrera Original code.                                   #
#                           Add new history entries as needed.                 #
#                                                                              #
#                                                                              #
################################################################################
################################################################################
################################################################################
#                                                                              #
#  Copyright (c) 2022-present Esteban Herrera C.                               #
#  stv.herrera@gmail.com                                                       #
#                                                                              #
#  This program is free software; you can redistribute it and/or modify        #
#  it under the terms of the GNU General Public License as published by        #
#  the Free Software Foundation; either version 3 of the License, or           #
#  (at your option) any later version.                                         #
#                                                                              #
#  This program is distributed in the hope that it will be useful,             #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
#  GNU General Public License for more details.                                #
#                                                                              #
#  You should have received a copy of the GNU General Public License           #
#  along with this program; if not, write to the Free Software                 #
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   #

# uploader.py
# Sends a POST request with a JSON payload to a specified API endpoint and
# handles the response.

import requests
import json

# Define the API endpoint
api_url = 'http://127.0.0.1:5000/api/save_json'

# Sample JSON payload
sample_json_data = {
    "name": "John Doe",
    "age": 30,
    "city": "Example City"
}

try:
    # Send a POST request to the API endpoint with JSON payload
    response = requests.post(api_url, json=sample_json_data)

    # Check the response status
    if response.status_code == 200:
        print("JSON data saved successfully.")
        print("Response:", response.json())
    else:
        print(f"Error: {response.status_code}")
        print("Response:", response.json())

except requests.exceptions.RequestException as e:
    print(f"Request failed: {e}")