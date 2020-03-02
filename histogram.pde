PImage img;
int[] redBins = new int[256];
int[] greenBins;
int[] blueBins;

void setup(){
    size(400,400);
    surface.setResizable(true);
    img = loadImage("baboon.png");
    surface.setSize(img.width,img.height);
}

void draw(){
    image(img,0,0);
}

void getBins(String binColor){
    color c;
    for (int x = 0; x < img.width; x++){
        for (int y = 0; y < img.height; y++){
            c = get(x,y);
            if (binColor == "red"){redBins[int(red(c))]++;}
            if (binColor == "green"){greenBins[int(green(c))]++;}
            if (binColor == "blue"){blueBins[int(blue(c))]++;}
        }
    }
}

void drawHist(String binColor){
    int[] bin = new int[256];
    if (binColor == "red") bin = redBins;
    if (binColor == "green") bin = greenBins;
    if (binColor == "blue") bin = blueBins;
    int histMax = max(bin);
    stroke(255,0,0);
    for (int i = 0; i <= img.width; i+=2){
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(bin[which], 0, histMax, img.height, 0));
        line(i, img.height, i, y);
    }
}

void keyReleased(){
    if (key == 'h'){
        getBins("red");
        getBins("green");
        getBins("blue");
        drawHist("red");
        drawHist("green");
        drawHist("blue");
    }
}




