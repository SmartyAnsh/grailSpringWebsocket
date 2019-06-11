package com.smartdiscover

class Comment {

    String comment

    static belongsTo = [post: Post, user: User]

    static constraints = {
        comment nullable: false, blank: false
        user nullable: false, blank: false
        post nullable: false, blank: false
    }

    static mapping = {
        post lazy: false, fetch: 'join'
        user lazy: false, fetch: 'join'
    }

    String toString() {
        "Comment - ${comment}"
    }

    Map toMap() {
        return [id: id, comment: comment, postId: post?.id, userName: user?.firstName]
    }
}
