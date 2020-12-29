import json
import os
import requests

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

from statsmodels.tsa.arima.model import ARIMA
from statsmodels.tsa.holtwinters import ExponentialSmoothing
from statsmodels.tsa.seasonal import seasonal_decompose

# Load credentials
from dotenv import load_dotenv
load_dotenv(os.path.join("C:\\Github\\credentials.env"))
EIA_API_TOKEN = os.getenv("EIA_API_TOKEN")

# Test request
response = requests.get(f"http://api.eia.gov/series/?api_key={EIA_API_TOKEN}&series_id=ELEC.GEN.ALL-NY-99.M")
print(response)

# Turns json file to dictionary
response_dict = response.json()
response_dict.keys()

# Save data as dataframe
elec_all_gen = pd.DataFrame(response_dict["series"][0]["data"])
elec_all_gen.columns = ["date", "net_generation"]

elec_all_gen.date = pd.to_datetime(elec_all_gen.date, format="%Y%m")
elec_all_gen.dtypes
elec_all_gen = elec_all_gen.sort_values(["date"]).reset_index()

sns.relplot(data=elec_all_gen, x="date", y="net_generation", kind="line")
plt.show()

# Additive seasonal decomposition
decomp = elec_all_gen.net_generation
decomp_results = seasonal_decompose(decomp, model="additive", period=12)
decomp_results.plot()
plt.show()

# Multiplicative seasonal decomposition
decomp = elec_all_gen.net_generation
decomp_results = seasonal_decompose(decomp, model="multiplicative", period=12)
decomp_results.plot()
plt.show()