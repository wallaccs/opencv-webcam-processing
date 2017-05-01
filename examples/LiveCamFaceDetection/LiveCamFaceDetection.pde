import processing.video.Capture;
import gab.opencv.OpenCV;
import java.awt.Rectangle;

Capture cam;
OpenCV opencv;

// input resolution
int w = 320, h = 240;

// output zoom
int zoom = 3;


void setup() {

  size(960,720);

  // capture camera with input resolution
  cam = new Capture(this, w, h);
  cam.start();

  // init OpenCV with input resolution
  opencv = new OpenCV(this, w, h);

  // setup for facial recognition
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
}


void draw() {

  // get the camera image
  opencv.loadImage(cam);

  // detect faces
  Rectangle[] faces = opencv.detect();

  // zoom to input resolution
  scale(zoom);

  // draw input image
  image(opencv.getInput(), 0, 0);

  // draw rectangles around detected faces
  fill(255, 64);
  strokeWeight(3);
  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }

  // show performance and number of detected faces on the console
  if (frameCount % 50 == 0) {
    println("Frame rate:", round(frameRate), "fps");
    println("Number of faces:", faces.length);
  }
  
}

// read a new frame when it's available
void captureEvent(Capture c) {
  c.read();
}
