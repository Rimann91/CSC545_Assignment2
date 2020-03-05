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

boolean histDisplay = false;
boolean imgDisplay = false;

String displayText = "press '1' for original image \n press '2' for stretched image \n press '3' for equalized image \n"+
                    "press 'i' for original histogram \n press 's' for stretched histogram \n press 'e' for equalized histogram";

void setup(){
    size(400,400);
    surface.setResizable(true);
    originalImg = loadImage("baboon.png");
    img = originalImg;
    //img = loadImage("th.jpg");
    surface.setSize(img.width,img.height);
    background(0);
    textSize(32);
    textAlign(CENTER, TOP);
}

void draw(){

    text(displayText, width/2, 0);
    if(keyPressed){
        if (key == 'h' || key == 's' || key == 'e'){
            histDisplay = true;
        }
        else if (key == '1' || key == '2' || key == '3'){
            imgDisplay = true;
        }
        if (histDisplay){
            surface.setSize(840, height);
            histDisplay = false;
        }
        else if (imgDisplay){
            surface.setSize(img.width, img.height);
            imgDisplay = false;
        }
    }
}

void getBins(){
    color c; 
    
    redBins = new int[256];
    greenBins = new int[256];
    blueBins = new int[256];

    for (int x = 0; x < img.width; x++){
        for (int y = 0; y < img.height; y++){
            c = img.get(x,y);
            redBins[int(red(c))]++;
            greenBins[int(green(c))]++;
            blueBins[int(blue(c))]++;
        }
    }
}

void drawHist(){
    int[] bin = new int[256];
    int maximum_value = 0;
    int rPos = 20, gPos = rPos+276, bPos = gPos+276;
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
        image(img,0,0);
        getBins();
        imgDisplay = true;
        displayText = "original image";
    }
    else if (key == '2'){
        clear();
        image(imgStretch(),0,0);
        getBins();
        imgDisplay = true;
        displayText = "stretched image";
    }
    else if (key == '3'){
        image(imgEqualize(),0,0);
        getBins();
        imgDisplay = true;
        displayText = "equalized image";
    }
    else if (key == 'h'){
        img = originalImg;
        getBins();
        clear();
        drawHist();
        histDisplay = true;
        displayText = "original histogram";
    }
    else if (key == 's'){
        img = imgStretch();
        getBins();
        clear();
        drawHist();
        img = originalImg;
        histDisplay = true;
        displayText = "stretched histogram";
    }
    else if (key == 'e'){
        img = imgEqualize();
        getBins();
        clear();
        drawHist();
        img = originalImg;
        histDisplay = true;
        displayText = "equalized histogram";
    }
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

PImage imgEqualize(){

    PImage outImage = createImage(img.width, img.height, RGB);

    // What is the point of PMF? Tutorial says it needs to be calculated
    // But it never explains what to use it for

    float rPMF = sumArray(redBins)/255;
    float gPMF = sumArray(greenBins)/255;
    float bPMF = sumArray(blueBins)/255;

    float[] rCDF = getCDF(redBins);
    float[] gCDF = getCDF(greenBins);
    float[] bCDF = getCDF(blueBins);

    for (int x = 0; x < img.width; x++){
        for (int y = 0; y < img.height; y++){
            color newc;
            color oldc = img.get(x,y);
            int oldr = int(red(oldc));
            int oldg = int(green(oldc));
            int oldb = int(blue(oldc));

            newc = color(int(ceil(rCDF[oldr]*244)), int(ceil(gCDF[oldg]*244)), int(ceil(bCDF[oldb]*244)));
            outImage.set(x,y,newc);
        }
    }
    return outImage;
}

float[] getCDF(int[]inHist){
    float[] outHist = new float[inHist.length];
    float max_value;
    for (int i = 1 ; i < inHist.length; i++){
        outHist[i] = outHist[i-1]+inHist[i];
    }
    max_value = max(outHist);
    for (int i = 0; i < outHist.length; i++){
        outHist[i] = outHist[i]/max_value;
    }
    return outHist;
}

int sumArray(int[] inArray){
    int sum = 0;
    for (int i = 0; i < inArray.length; i++){
        sum += inArray[i];
    }
    return sum;
}
void histoOriginal(){}

void histoStretch(){}

void histoEqualize(){}
