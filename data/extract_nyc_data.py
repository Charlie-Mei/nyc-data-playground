import json
import os
import requests

import numpy as np
import pandas as pd

# Load credentials
from dotenv import load_dotenv
load_dotenv(os.path.join("C:\\Github\\credentials.env"))
EIA_API_TOKEN = os.getenv("EIA_API_TOKEN")

def create_df_from_api(series_id, token=EIA_API_TOKEN):
    """ From an API call, save the JSON file into a csv """
    api_url = f"http://api.eia.gov/series/?api_key={token}&series_id={series_id}"
    response = requests.get(api_url)
    print(response)
    
    # read the json file
    response_dict = response.json()
    df = pd.DataFrame(response_dict["series"][0]["data"])
    return df

# grab total consumption for residential, commercial, and overall sectors
series_ids = {"residential": "SEDS.TERCB.NY.A",
              "commercial": "SEDS.TECCB.NY.A",
              "total": "SEDS.TETCB.NY.A"}


data_tables = {}
for series in series_ids:
    data_tables[series] = create_df_from_api(series_ids[series])
    data_tables[series].columns = ["year", series+"_consumption"]
    print(data_tables[series].head())

# saev the outputs to the data folder
os.chdir(r'C:\github\nyc-energy-dash\data')
for series in data_tables:
    data_tables[series].to_csv(series+".csv", index=False)
    

# NYC water data
water_consumption = pd.read_csv("https://data.cityofnewyork.us/resource/ia2d-e54m.csv")
water_consumption.to_csv("water_consumption.csv", index=False)

# NYC air quality
air_quality = pd.read_csv("https://data.cityofnewyork.us/resource/c3uy-2p5r.csv")
air_quality.to_csv("air_quality.csv", index=False)