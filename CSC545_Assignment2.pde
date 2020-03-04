/*
William Hughes
CSC 545
Assignment #2

Histograms of images
*/

PImage img;
int[] redBins;
int[] greenBins;
int[] blueBins;

void setup(){
    size(400,400);
    surface.setResizable(true);
    img = loadImage("baboon.png");
    surface.setSize(img.width,img.height);
}

void draw(){
    //if (keyPressed==true){
    //    if (key == '1'){
    //        clear();
    //        image(img,0,0);
    //    }
    //    else if (key == 'h'){
    //        getBins("red");
    //        clear();
    //        //getBins("green");
    //        //getBins("blue");
    //        drawHist("red");
    //        //drawHist("green");
    //        //drawHist("blue");
    //    }
    //}
}

void getBins(){
    color c; 
    
    redBins = new int[256];
    greenBins = new int[256];
    blueBins = new int[256];

    for (int x = 0; x < img.width; x++){
        for (int y = 0; y < img.height; y++){
            c = get(x,y);
            redBins[int(red(c))]++;
            greenBins[int(green(c))]++;
            blueBins[int(blue(c))]++;
        }
    }
}

void drawHist(String binColor){
    int[] bin = new int[256];
    if (binColor == "red") {
        bin = redBins; 
        stroke(255,0,0);
    }
    if (binColor == "green"){
        bin = greenBins; 
        stroke(0,255,0);
    }
    if (binColor == "blue"){ 
        bin = blueBins; 
        stroke(0,0,255);
    }
//    int histMax = max(bin);
//    for (int i = 0; i <= width; i+=2){
//        int which = int(map(i, 0, img.width, 0, 255));
//        int y = int(map(bin[which], 0, histMax, img.height, 0));
//        line(i, img.height, i, y);
//    }
    for (int i = 0; i < 256; i++){
        int y = bin[i];
        int x = i;
        line(i,img.height,i,y);
    }
}

// SOME COMMMENTS

void keyReleased(){
    if (key == '1'){
        clear();
        image(img,0,0);
        getBins();

    }
    else if (key == '2'){}
    else if (key == '3'){}
    else if (key == 'h'){
        clear();
        surface.setSize(width*3, height);
        drawHist("red");
        drawHist("green");
        drawHist("blue");
    }
    else if (key == 's'){}
    else if (key == 'e'){}
    else if (key == 'r'){
        clear();
        drawHist("red");
    }
    else if (key == 'g'){
        clear();
        drawHist("green");
    }
    else if (key == 'b'){
        clear();
        drawHist("blue");
    }
}

// Processing functions

void imgStretch(){}

void imgEqualize(){}

void histoOriginal(){}

void histoStretch(){}

void histoEqualize(){}
