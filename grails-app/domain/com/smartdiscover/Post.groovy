package com.smartdiscover

class Post {

    String content

    static constraints = {
        content nullable: false, blank: false
        user nullable: false, blank: false
    }

    static belongsTo = [user: User]

    static mapping = {
        comments lazy: false, fetch: 'join'
    }

    static hasMany = [comments: Comment]

    String toString() {
        "Post #${id} - ${content} by ${user?.firstName}"
    }

    Map toMap() {
        return ["id": id, post: this.toString(), comments: this?.comments*.toMap()]
    }
}
