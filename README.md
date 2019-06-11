# grailSpringWebsocket
An example of Grails Spring WebSocket Integration.

A simple integration of Grails and Spring WebSocket where messages are sent to `/topic` or `/queue` and received at `/app`.

To show all the required possibilities of webSocket integration a UserController, PostService and CommentWebSocket is created.

When userId is provided, all posts and corresponding comments are published. 
After that when the same user posts - it agains get publish, and if any user comment on any posts - it also gets publish

Specifications are following:
 
`Grails 3.2.9`

`grails-spring-websocket 2.4.1`


