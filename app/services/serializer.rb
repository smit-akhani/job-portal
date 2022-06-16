class Serializer
    def serializer(data, serialier_name)
        ActiveModelSerializers::SerializableResource.new(data,each_serializer:serialier_name)
        
    end
end