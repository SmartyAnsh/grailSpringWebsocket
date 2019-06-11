<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>

    <asset:javascript src="application"/>
    <asset:javascript src="spring-websocket"/>

    <script type="text/javascript">
        $(function () {
            var socket = new SockJS("${createLink(uri: '/stomp')}");
            var client = Stomp.over(socket);
            console.log("running::::");
            client.connect({}, function (frame) {
                console.log('Connected::: ' + frame);
                client.subscribe("/topic/greet", function (message) {
                    console.log("message:::::: "+message);
                    $("#helloDiv").append(message.body);
                }, null);
            });

            $("#helloButton").click(function () {
                client.send("/app/greet", null, JSON.stringify('world123'));
            });
        });
    </script>
</head>

<body>
<button id="helloButton">hello</button>

<div id="helloDiv"></div>

</body>
</html>