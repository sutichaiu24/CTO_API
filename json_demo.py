import json
from requests import request ;
from urllib.request import urlopen

import requests
#consume data
with urlopen("http://localhost:3030/results/") as response :
  source = response.read()

data = json.loads(source)
print(json.dumps(data,indent=2))

totalRuns =0 
success =0 
for item in data :
    totalRuns  = totalRuns+1
    totalDuration = item['duration']
    if item['status'] == 'Passed': 
      success  = success + 1
    
successRate = success/totalRuns
print(totalRuns,totalDuration,successRate,success)
data_set = {"id":[1],"name":"Powerbuy","succesRate":[successRate],"totalRuns":[totalRuns],"totalDuration":[totalDuration]}

#write json
with open('example_request.json', 'w') as f:
  json.dump(data_set, f,indent=1)



#feed the data back the mock server 
url  = 'http://localhost:3030/stabilty'
headers =  {'Content-type': 'application/json', 'Accept': 'text/plain'}
data = data_set
r = requests.post(url, data,headers={'Authorization': 'Basic authenticationKeyForMackServer'})
print(r.text)

