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
    image(img,0,0);
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

void getBins(String binColor){
    color c; 
    redBins = new int[256];
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
    for (int i = 0; i <= width; i+=1){
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(bin[which], 0, histMax, img.height, 0));
        line(i, img.height, i, y);
    }
}

void keyReleased(){
    if (key == '1'){
        clear();
        image(img,0,0);
    }
    else if (key == '2'){}
    else if (key == '3'){}
    else if (key == 'h'){
        getBins("red");
        clear();
        //getBins("green");
        //getBins("blue");
        drawHist("red");
        //drawHist("green");
        //drawHist("blue");
    }
    else if (key == 's'){}
    else if (key == 'e'){}
    else if (key == 'r'){
        getBins("red");
        clear();
        drawHist("red");
    }
    else if (key == 'g'){
        getBins("green");
        clear();
        drawHist("green");
    }
    else if (key == 'b'){
        getBins("blue");
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