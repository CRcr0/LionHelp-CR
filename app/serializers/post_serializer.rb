class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :location, :startTime, :endTime, :taskDetails, :credit, :email, :helperStatus, :helperEmail, :helperComplete, :requesterComplete
end
