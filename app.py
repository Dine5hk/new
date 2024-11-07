from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_restful import Api, Resource

app = Flask(__name__)
CORS(app)  
api = Api(app) 

users = {}
user_id_counter = 1

class User(Resource):
    def get(self, user_id=None):
        if user_id is not None:
            user = users.get(user_id)
            if user:
                return jsonify(user)
            return jsonify({"message": "User not found"}), 404
        else:
            return jsonify(list(users.values()))  

    def post(self):
        global user_id_counter
        user_data = request.get_json()
        user_id = user_id_counter
        users[user_id] = {
            "id": user_id,
            "name": user_data.get("name"),
            "email": user_data.get("email"),
            "mobile": user_data.get("mobile")  
        }
        user_id_counter += 1
        return jsonify(users[user_id]), 201

    def put(self, user_id):
        user_data = request.get_json()
        user = users.get(user_id)
        if user:
            user['name'] = user_data.get("name", user['name'])
            user['email'] = user_data.get("email", user['email'])
            user['mobile'] = user_data.get("mobile", user['mobile']) 
            return jsonify(user)
        return jsonify({"message": "User not found"}), 404

    def delete(self, user_id):
        if user_id in users:
            del users[user_id]
            return jsonify({"message": "User deleted"}), 204
        return jsonify({"message": "User not found"}), 404

api.add_resource(User, '/users', '/users/<int:user_id>')

if __name__ == '__main__':
    app.run(debug=True)
