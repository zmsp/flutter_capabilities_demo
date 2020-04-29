from flask import Flask, jsonify, request
import os
from flask_cors import CORS, cross_origin
app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'


@app.route('/')
def hello():
    return "Hello World!"


from flask import send_file


@app.route('/image')
def get_image():
    return send_file("conon.jpeg", mimetype='image/jpg')


@app.route("/get", methods=["GET"])
@cross_origin()
def message():
    posted_data = request.args.get('param1')
    print(request)


    return jsonify("Reply from python" + posted_data + "!!!")


@app.route("/post", methods=["POST"])
@cross_origin()
def setName():
    if request.method == 'POST':
        test = request
        print(request)
        posted_data = request.get_json()
        print(posted_data)
        print("Data posted" +  str(request.get_json()) +"   answer is " + posted_data["answer"])

        return "Data posted" +  str(request.get_json()) +"   answer is " + posted_data["answer"]


@app.route('/upload/', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        file = request.files['file']
        if file:
            filename = file.filename
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return jsonify(str("File received " + file))


if __name__ == '__main__':
    app.run()
