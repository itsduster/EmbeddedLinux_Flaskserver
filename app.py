from flask import Flask, render_template, Response, request, redirect, url_for
import cv2
import os
from datetime import datetime

app = Flask(__name__)
capture_folder = "static/captured_images"
os.makedirs(capture_folder, exist_ok=True)

# Set up the camera capture
camera = cv2.VideoCapture(0)

def gen_frames():
    while True:
        success, frame = camera.read()
        if not success:
            break
        else:
            ret, buffer = cv2.imencode('.jpg', frame)
            frame = buffer.tobytes()
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/video_feed')
def video_feed():
    return Response(gen_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/capture', methods=['POST'])
def capture():
    success, frame = camera.read()
    if success:
        img_name = f"{datetime.now().strftime('%Y%m%d_%H%M%S')}.jpg"
        img_path = os.path.join(capture_folder, img_name)
        cv2.imwrite(img_path, frame)
        return redirect(url_for('display', filename=img_name))
    return "Failed to capture image"

@app.route('/display/<filename>')
def display(filename):
    return render_template('display.html', filename=filename)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
