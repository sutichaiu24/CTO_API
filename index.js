const express = require('express')
const app = express();
const projects = require('./projects');
const results =  require('./results');

app.get('/projects' , (req, res)=>{
    res.end(JSON.stringify(projects))
})
app.get('/projects/:id', (req,res) =>{
    console.log(projects)
    res.json(projects.find(project => project.id == req.params.id))
})
app.get('/results/:projectId',(req,res) =>{
    console.log(results)
    res.json(results.find(result => result.runId == req.params.projectId))
})


app.post('/stabilty',(req,res,next) =>{
    const bearerHeader = req.headers['authorization']
    if(bearerHeader == 'Basic authenticationKeyForMackServer'){
        console.log(bearerHeader)
        projects.push(req.body)
        console.log(req)
        res.status(201).json(req.body)

     } else  {
        res.sendStatus(403);
            
            }
})

 app.listen(3030,()=> {
     console.log('Server started on port 3030'); 
})
