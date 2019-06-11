package com.smartdiscover

import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.SendTo

/**
 *
 * User Controller
 * author - Anshul
 */
class UserController {

    def postService

    def index() {}

    def post() {
        def post = new Post(content: "This is my first Post...", user: User.get(2))
        post.save(failOnError: true, flush: true)

        postService.notifyFollower(post)
        render "posted"

    }

    def comment() {
        def comment = new Comment(comment: params?.comment, user: User.get(params?.userId), post: Post.get(params.postId))
        comment.save(failOnError: true, flush: true)

        postService.notifyPost(comment)
        render "commented"
    }

    /**
     * publish all posts if invoked
     * @param userId
     * @return
     */
    @MessageMapping("/allPosts")
    @SendTo("/topic/allPosts")
    protected List<Map<String, String>> allPosts(String userId) {
        return postService.fetchAllPost(userId)
    }

}
