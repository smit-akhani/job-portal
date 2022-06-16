class Token
    def get_user_from_token(request)
       p request.headers['Authorization']
        if(request.headers['Authorization']==nil)
            
            return nil
        end
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.devise[:jwt_secret_key]).first
        user_id = jwt_payload['sub']
        p user_id
        return User.find(user_id.to_s)
    end

    def get_company_from_token(request)
        if(request.headers['Authorization']==nil)
            return nil
        end
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.devise[:jwt_secret_key]).first
        company_id = jwt_payload['sub']
        p company_id
        Company.find(company_id.to_s)
    end
end