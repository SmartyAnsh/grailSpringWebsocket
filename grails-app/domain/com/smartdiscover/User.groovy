package com.smartdiscover

class User {
    String userId
    String firstName
    String lastName

    static constraints = {
        userId(size: 3..20, unique: true)
        firstName nullable: false, blank: false
        lastName nullable: false, blank: false
    }

    static mapping = {
    }

    static hasMany = [posts: Post, following: User]

    String toString() {
        "$userId - $firstName"
    }
}
