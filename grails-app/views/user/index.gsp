<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>

    <asset:javascript src="application"/>
    <asset:javascript src="spring-websocket"/>

    <script type="text/javascript">
        $(function () {
            var socket = new SockJS("${createLink(uri: '/stomp')}");
            var client1 = Stomp.over(socket);
            console.log("running::::");
            client1.connect({}, function (frame) {
                console.log('Connected::: ' + frame);
                client1.subscribe("/topic/allPosts", function (posts) {
                    console.log("posts:::::: " + posts);
                    var postsJson = JSON.parse(posts.body);
                    for (var i = 0; i < postsJson.length; i++) {
                        $("#postsDiv").append("<div id='post" + postsJson[i].id + "'>" + postsJson[i].post + "</div>");
                        $("#postsDiv").append("<br>");
                        var commentsJson = postsJson[i].comments;
                        for (var j = 0; j < commentsJson.length; j++) {
                            $("#post" + commentsJson[j].postId).append("<div id='comment" + commentsJson[j].id + "' style='margin-left:20px'>" + commentsJson[j].comment + " by " + commentsJson[j].userName + "</div>");
                        }
                    }
                }, null);
            });

            var socket2 = new SockJS("${createLink(uri: '/stomp')}");
            var client2 = Stomp.over(socket2);
            client2.connect({}, function (frame) {
                console.log('Connected::: ' + frame);
                client2.subscribe("/topic/post", function (message) {
                    console.log("post:::::: " + message);
                    var messageJson = JSON.parse(message.body);
                    $("#postsDiv").append("<div id='post" + messageJson.id + "'>" + messageJson.post + "</div>");
                    $("#postsDiv").append("<br>");
                }, null);
            });

            $("#getPosts").click(function () {
                client2.send("/app/allPosts", null, $("#user").val());
            });

            var socket3 = new SockJS("${createLink(uri: '/stomp')}");
            var client3 = Stomp.over(socket3);
            client3.connect({}, function (frame) {
                console.log('Connected::: ' + frame);
                client3.subscribe("/topic/allComments", function (comments) {
                    console.log("comments:::::: " + comments);
                    var commentsJson = JSON.parse(comments.body);
                    for (var i = 0; i < commentsJson.length; i++) {
                        $("#post" + commentsJson[i].postId).append("<div id='comment" + commentsJson[i].id + "' style='margin-left:20px'>" + commentsJson[i].comment + " by " + commentsJson[i].userName + "</div>");
                    }
                }, null);
            });

            $("#getComments").click(function () {
                client2.send("/app/allComments", null, $("#user").val());
            });

            var socket4 = new SockJS("${createLink(uri: '/stomp')}");
            var client4 = Stomp.over(socket4);
            client4.connect({}, function (frame) {
                console.log('Connected::: ' + frame);
                client4.subscribe("/topic/comment", function (message) {
                    console.log("comment:::::: " + message);
                    var messageJson = JSON.parse(message.body);
                    $("#post" + messageJson.postId).append("<div id='comment" + messageJson.id + "' style='margin-left:20px'>" + messageJson.comment + " by " + messageJson.userName + "</div>");
                }, null);
            });

        });
    </script>
</head>

<body>
User Id: <g:textField name="user" id="user"/>
<button id="getPosts">Fetch All Post</button>
<button id="getComments">Fetch All Comments</button>

<div id="postsDiv" style="margin: 10px 10px 10px 10px"></div>

</body>
</html>