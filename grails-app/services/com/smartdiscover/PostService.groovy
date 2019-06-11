package com.smartdiscover

import grails.plugin.springwebsocket.WebSocket

/**
 *
 * Service implementing WebSocket trait and hence have SimpMessageSendingOperations available directly
 * author - Anshul
 */
class PostService implements WebSocket {

    /**
     * publish saved post
     * @param post
     */
    void notifyFollower(Post post) {
        convertAndSend "/topic/post", post.toMap()
    }

    /**
     * publish saved comment
     * @param comment
     */
    void notifyPost(Comment comment) {
        convertAndSend "/topic/comment", comment.toMap()
    }

    def fetchAllPost(userId) {
        def posts = []
        Post.withNewSession {
            posts = Post.findAllByUser(User.get(Long.parseLong(userId)))
        }
        return posts*.toMap()
    }


}