/*Perform edge detection using a mask
*/
String fname1 = "emptyroad.jpg", fname2 = "";
String loadName = fname1;
float[][] k1 = {{1/9.0, 1/9.0, 1/9.0}, {1/9.0, 1/9.0, 1/9.0}, {1/9.0, 1/9.0, 1/9.0}}; //Blur
float[][] k2 = {{-1.0, -1.0, -1.0}, {0.0, 0.0, 0.0}, {1.0, 1.0, 1.0}};  //Prewitt horizontal
float[][] k3 = {{-1.0, 0.0, 1.0}, {-1.0, 0.0, 1.0}, {-1.0, 0.0, 1.0}};  //Prewitt vertical
float[][] k4 = {{-1.0, -2.0, -1.0}, {0.0, 0.0, 0.0}, {1.0, 2.0, 1.0}};  //Sobel horizontal
float[][] k5 = {{-1.0, 0.0, 1.0}, {-2.0, 0.0, 2.0}, {-1.0, 0.0, 1.0}};  //Sobel vertical
float[][] k6 = {{-1.0, -1.0, -1.0}, {-1.0, 8.0, -1.0}, {-1.0, -1.0, -1.0}}; //Laplacian
PImage[] img = new PImage[10]; //I used an array of images; you could do it differently

void setup() {
  size(500, 500);
  surface.setResizable(true);
  //Load and display initial image
  img[0] = loadImage(loadName);
  surface.setSize(img[0].width, img[0].height);
  imgIndex = 0;
  //Add code here to call filter function
}
void draw() {
  image(img[imgIndex], 0, 0);
}
PImage convolve(PImage source, float[][] kernel) {
  PImage target = createImage(source.width, source.height, RGB);
  //Your code here to implement edge detection 
  return target;
}
//Add two images and return the result (used to add an edge image and for unsharp filtering)
PImage addImages(PImage img1, PImage img2) {
  PImage target = createImage(img1.width, img2.height, RGB); //Assume both images are the same size
  //Your code here to add images; make sure pixels stay in range 
  return target;
}
//Subtract images - use abs value; one will be a blurred image (used for unsharp filtering)
PImage subtractImages(PImage img1, PImage img2) {
  PImage target = createImage(img1.width, img2.height, RGB); //Assume they are the same size
  //Your code here to subtract images - use abs value
  return target;
}
void keyReleased() {
  //Add code to set imgIndex to select image to display
}
