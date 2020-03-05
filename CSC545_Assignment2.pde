/*
William Hughes
CSC 545
Assignment #2

Histograms of images
*/

PImage img;
PImage originalImg;
int[] redBins;
int[] greenBins;
int[] blueBins;

color red = color(255,0,0);
color green = color(0,255,0);
color blue = color(0,0,255);

void setup(){
    size(400,400);
    surface.setResizable(true);
    originalImg = loadImage("baboon.png");
    img =originalImg;
    //img = loadImage("th.jpg");
    surface.setSize(img.width,img.height);
}

void draw(){
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

void drawHist(){
    int[] bin = new int[256];
    int maximum_value = 0;
    int rPos = 20, gPos = rPos+256, bPos = gPos+256;
    int value;

    if (max(redBins) > maximum_value) maximum_value = max(redBins);
    if (max(greenBins) > maximum_value) maximum_value = max(greenBins);
    if (max(blueBins) > maximum_value) maximum_value = max(blueBins);

    for (int i = 0; i < 256; i+=1){
        // Map i (from 0..img.width) to a location in the histogram (0..255)
        value = int(map(redBins[i], 0, maximum_value, 0, height/2));
        stroke(red);
        line(i+rPos, height, i+rPos, height-value);

        value = int(map(greenBins[i], 0, maximum_value, 0, height/2));
        stroke(green);
        line(i+gPos, height, i+gPos, height-value);

        value = int(map(blueBins[i], 0, maximum_value, 0, height/2));
        stroke(blue);
        line(i+bPos, height, i+bPos, height-value);
    }
}

void keyReleased(){
    if (key == '1'){
        clear();
        //surface.setSize(img.width, img.height);
        image(img,0,0);
        getBins();

    }
    else if (key == '2'){
        //clear();
        image(imgStretch(),0,0);
    }
    else if (key == '3'){}
    else if (key == 'h'){
        clear();
        //surface.setSize(img.width*3, height);
        drawHist();
    }
    else if (key == 's'){
        img = imgStretch();
        getBins();
        //surface.setSize(img.width*3, img.height);
        clear();
        drawHist();
        img = originalImg;
    }
    else if (key == 'e'){}
}

// Processing functions

PImage imgStretch(){
    PImage outImg = createImage(img.width, img.height, RGB);
    int minRed = findMin(redBins), maxRed = findMax(redBins);
    int minGreen = findMin(greenBins), maxGreen = findMax(greenBins);
    int minBlue =findMin(blueBins), maxBlue = findMax(blueBins);

    println("red: "+str(minRed)+" - "+str(maxRed));
    println("green: "+str(minGreen)+" - "+str(maxGreen));
    println("blue: "+str(minBlue)+" - "+str(maxBlue));

    for (int x = 0; x < outImg.width; x++){
        for (int y = 0; y < outImg.height; y++){
            color thisColor = img.get(x,y);

            float thisRed = red(thisColor);
            float thisGreen = green(thisColor);
            float thisBlue = blue(thisColor);

            int newRed = int(((thisRed-minRed)/(maxRed-minRed))*255);
            //println("("+str(thisRed)+"-"+str(minRed)+")/("+str(maxRed)+"-"+str(minRed)+"))*255");
            int newGreen = int(((thisGreen-minGreen)/(maxGreen-minGreen))*255);
            int newBlue = int(((thisBlue-minBlue)/(maxBlue-minBlue))*255);

            color newColor = color(newRed,newGreen,newBlue);

            outImg.set(x,y,newColor);
        }
    }
    return outImg;
}

int findMin(int[] inArray){
    int min = 0;
    for (int i = 0; i < inArray.length; i++){
        if (inArray[i] != 0){
            min = i;
            return min;
        }
    }
    return min;
}

int findMax(int[] inArray){
    int max = inArray.length;
    for (int i = inArray.length-1; i > 0; i--){
        if (inArray[i] != 0){
            max = i;
            return max;
        }
    }
    return max;
}

void imgEqualize(){}

void histoOriginal(){}

void histoStretch(){}

void histoEqualize(){}
