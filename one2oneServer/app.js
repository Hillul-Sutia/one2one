var express = require('express');
var app = require('express')();
const path = require('path')
var server = require('http').Server(app);
var io = require('socket.io')(server);

var allUsers = [];
var userDetails={};
temp =[]
//static folder
app.use(express.static(path.join(__dirname,'web')));

function emitUsers() {
    io.emit('users',allUsers);    
    console.log('users',allUsers);
    //console.log('User socket ids ',userDetails);
}
// function emitUserDetails(){
//     io.emit('userDetails',userDetails)
// }
function removeUser(user) {
    allUsers= allUsers.filter(function(ele){ 
        return ele != user; 
    });
    //delete userDetails[user]
    
}

//socket listeners
io.on('connection', function (socket) {
    var userName = socket.request._query.userName;
    var socketId=socket.id
    temp.push(userName);
    temp.push(socketId);
    allUsers.push(temp);
    temp=[]
    //userDetails[userName]=socket.id;
    emitUsers();
    //emitUserDetails();
    var msg = `🔥👤 ${userName} has joined! 😎🔥`;

    console.log(msg)

    //broadcast when a user connects
    io.emit('message', {
        "message": msg
    }
    );
    socket.on('disconnect', () => {       
      
        var disMsg = `${userName} has disconnected! 😭😭`;
        console.log(disMsg);
        io.emit('message', {
            "message": disMsg,
        });
        removeUser(userName);
        emitUsers()
    });

    socket.on('message', (data) => {
        console.log(`👤 ${data.userName} : ${data.message}`)
        io.emit('message', data);
    });
    // socket.on("private message",({content,to})=>{
    //     socket.to(to).emit("private message",{
    //         content,
    //         from:socket.id,
    //     })
    // })


});



const PORT = 8080;

server.listen(PORT,'0.0.0.0',()=>{
    console.log('Server up and running at',PORT);
});