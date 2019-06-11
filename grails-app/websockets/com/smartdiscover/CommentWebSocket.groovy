package com.smartdiscover

import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.SendTo

/**
 *
 * Comment WebSocket
 * author - Anshul
 */
class CommentWebSocket {

    /**
     * publish all comments if invoked
     * @return
     */
    @MessageMapping("/allComments")
    @SendTo("/topic/allComments")
    List<Map<String, String>> allComments() {
        def comments
        Comment.withNewSession {
            comments = Comment.findAll()
        }
        def commentList = comments*.toMap()
        return commentList
    }

}