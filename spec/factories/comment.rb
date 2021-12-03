FactoryBot.define do
    factory :comment do
        commenter { "abc@columbia.edu" }
        commentee { "xxxxx@columbia.edu" }
        content { "Instant Help! Really appreciate it!" }
        postID { 1 }
    end
end