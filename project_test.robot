*** Settings ***
Library     Collections
Library     String
Library     RequestsLibrary

*Variables ***
${url}      http://localhost:3030

*** Test Cases ***
Get Request Test project
        ${response}=    GET   ${url}/projects
Verify Get Project by Id keys
        Create Session      cto      ${url}
        ${resp}=    Get Request   cto    /projects/1
        
        Dictionary Should Contain Key        ${resp.json()}       id    
        Dictionary Should Contain Key        ${resp.json()}       name  
        ${jsondata}=  Set Variable  ${resp.json()}  

        Should Be Equal As Strings     ${jsondata['id']}        1
        Should Be Equal As Strings    ${jsondata['name']}     Powerbuy

  
Verify Post stability with valid token
        ${data}=    Create Dictionary   id=1    name=IM
        &{header}=    Create dictionary    Content-Type=Application/json       Authorization=Basic authenticationKeyForMackServer
        ${resp1}=  Post Request    cto         /stability  json=${data}   headers=${header}  
       
        Should Be Equal As Strings  ${resp1.status_code}  201
        


        


*** Keywords **

