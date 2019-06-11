package com.smartdiscover

class BootStrap {

    def init = { servletContext ->

        def user1 = User.findByUserId("user1")

        if (!user1) {
            user1 = new User(userId: "user1", firstName: "Norman", lastName: "Lewis").save(failOnError: true, flush: true)
        }

        if (!User.findByUserId("user2")) {
            def user2 = new User(userId: "user2", firstName: "Samwell", lastName: "Tar").save(failOnError: true, flush: true)

            user1.addToFollowing(user2).save(failOnError: true, flush: true)
        }


    }
    def destroy = {
    }
}
