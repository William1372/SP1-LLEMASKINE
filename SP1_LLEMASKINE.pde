import processing.sound.*;
PImage img, dæmonenImg, infoImage, startScreenImg, spinoginfo, bonusBeskedImg, lukInfo;
Symboler symbol1, symbol2, symbol3;
boolean visBokse = false, showStartScreen = true;
int nuværendeBoks = 1, opdateringsTid = 0, interval = 1000;
int saldo = 1000, indsats = 2;
boolean gevinstTjekket = false, derErGevinst = false, lavSaldo = false;
String gevinstBesked = ""; 
int startTid = 0, gevinstTid = 0;
SoundFile spinSound, winSound, jackpjerrotSound, backgroundMusic;
int gevinstVisningTid = 0, gevinstVisningVarighed = 1000;
PFont myFont, myFont2;
boolean showInfo = false;
int sidsteSpinTid = 0;
int spinCooldown = 3000;
String[] symbolFilnavne = {"candyfloss.png", "churros.png", "forlystelse.png", "turpas.png", "pjerrot.png", "bonus.png"};
int[] weights = {30, 25, 17, 15, 10, 3};

void setup() {
    size(1280, 720);
    
    img = loadImage("tivoli_baggrund.jpg");
    img.resize(1280, 720);
    dæmonenImg = loadImage("dæmonen.png");
    bonusBeskedImg = loadImage("bonusbesked.png");
    infoImage = loadImage("info.png");
    startScreenImg = loadImage("startscreen.png");
    spinoginfo = loadImage("spinoginfo.png");
    lukInfo = loadImage("lukInfo.png");
    myFont = createFont("Bungee_Inline.ttf", 30);
    myFont2 = createFont("Bungee_Inline.ttf", 20);
    spinSound = new SoundFile(this, "spinSound.wav");
    winSound = new SoundFile(this, "winSound.wav");
    jackpjerrotSound = new SoundFile(this, "jackpjerrot.wav");
    backgroundMusic = new SoundFile(this, "backgroundMusic.wav");
    backgroundMusic.loop();
    
    rectMode(CENTER);
    imageMode(CENTER);
   
}

void draw() {
    if (showStartScreen) {
        background(0);
        image(startScreenImg, width / 2, height / 2);
    } else {
        background(img);
        image(dæmonenImg, width / 2, 380);
        image(spinoginfo, width / 2, height / 2+15);
        image(bonusBeskedImg, width/2, height - 367);
        
        fill(195, 0, 0, 97);
        rect(width / 2, height / 2, 1080, 440);
        
        fill(255, 0, 0, 97);
        rect(width - 240, height - 50, 200, 40);
        fill(0);
        textAlign(CENTER, CENTER);
        textFont(myFont);
        text(indsats + " DKK", width - 220, height - 50);
        fill(255, 255, 0);
        textSize(29);
        text(indsats + " DKK", width - 220, height - 50);
        
        fill(255, 0, 0, 97);
        rect(width - 240, height - 90, 200, 40);
        fill(0);
        textFont(myFont);
        text("INDSATS", width - 240, height - 90);
        fill(255, 255, 0);
        textSize(29);
        text("INDSATS", width - 240, height - 90);
        
        bank();
    
        if (visBokse) {
            if (millis() - opdateringsTid > interval) {
                opdateringsTid = millis();
                nuværendeBoks++;
            }

            color firkant1Farve = color(255, 255, 255, 150);
            color firkant2Farve = color(255, 255, 255, 150);
            color firkant3Farve = color(255, 255, 255, 150);
            
            if (nuværendeBoks >= 2 && symbol2.getFilnavn().equals(symbol1.getFilnavn())) {
                firkant1Farve = color(0, 255, 0, 150);
                firkant2Farve = color(0, 255, 0, 150);
            }
            
            if (nuværendeBoks >= 3 && symbol3.getFilnavn().equals(symbol2.getFilnavn()) && symbol2.getFilnavn().equals(symbol1.getFilnavn())) {
                firkant3Farve = color(0, 255, 0, 150);
            }

            if (nuværendeBoks >= 1) {
                fill(firkant1Farve);
                rect(width / 4, height / 2, 200, 200);
                image(symbol1.getBillede(), width / 4, height / 2);
            }
            if (nuværendeBoks >= 2) {
                fill(firkant2Farve);
                rect(width / 2, height / 2, 200, 200);
                image(symbol2.getBillede(), width / 2, height / 2);
            }
            if (nuværendeBoks >= 3) {
                fill(firkant3Farve);
                rect(width * 3 / 4, height / 2, 200, 200);
                image(symbol3.getBillede(), width * 3 / 4, height / 2);
                
                if (!gevinstTjekket) {
                    tjekVinder();
                    gevinstTjekket = true;
                }
            }

            if (derErGevinst) {
              
                fill(0);
                textSize(64);
                textAlign(CENTER, CENTER);
                text(gevinstBesked, width / 2 + 2, height / 2 + 2);
                fill(0, 255, 0);
                text(gevinstBesked, width / 2, height / 2);
                
            }
            
        }
      if(saldo < indsats){
        
          textSize(50);
          textAlign(CENTER, CENTER);
          
          stroke(0);
          strokeWeight(3);
          fill(0);
          
          text("Din saldo er for lav...", width / 2, height / 2);
          
          fill(255,0,0,97);
          rect(width/2, height/2, 720, 100);
          
          textSize(52);
          fill(255,255,50);
          text("Din saldo er for lav...", width / 2, height / 2);
          
        
        }
                if (showInfo) {
        
        image(infoImage, width / 2, height / 2, 1180, 620);
        image(lukInfo, width / 2, height / 2, 1280, 720);
        }
    }
}

void keyPressed() {
  println("Key pressed");
    if (showStartScreen) {
        showStartScreen = false;
        println("Startskærm skjult via tast");
        return;
    }

    if (key == 'i') {
        indsats += 2;
        if (indsats > 100) {
            indsats = 2;
        }
        println("Ny indsats via 'i': " + indsats);
    } else if (key == 'u') {
        indsats -= 2;
        if (indsats < 2) {
            indsats = 2;
        }
        println("Ny indsats via 'u': " + indsats);
    }

    int nuværendeTid = millis(); 
     if (key == ' ' && nuværendeTid - sidsteSpinTid >= spinCooldown) {
        if (saldo >= indsats) {
            visBokse = true;
            opdateringsTid = millis();
            saldo -= indsats;

            symbol1 = tilfældigtSymbol();
            symbol2 = tilfældigtSymbol();
            symbol3 = tilfældigtSymbol();

            nuværendeBoks = 1;
            gevinstTjekket = false;
            gevinstBesked = "";
            derErGevinst = false;
            spinSound.play();

            sidsteSpinTid = nuværendeTid;
        }
    }
}

void mousePressed() {
    println("Mouse pressed");
    if (showStartScreen) {
        showStartScreen = false;
        return;
    }

    if (mouseX >= width - 310 && mouseX <= width - 120 && mouseY >= height - 90 && mouseY <= height - 50) {
        indsats += 2;
        if (indsats > 100) {
            indsats = 2;
        }
        println("Ny indsats: " + indsats);
    }
    
    if (dist(mouseX, mouseY, width - 50, height - 80) < 37.5) {
        showInfo = !showInfo;
    }

    int nuværendeTid = millis();
    if (nuværendeTid - sidsteSpinTid >= spinCooldown) {
        if (dist(mouseX, mouseY, width / 2, height - 80) < 100) {
            if (saldo >= indsats) {
                visBokse = true;
                opdateringsTid = millis();
                saldo -= indsats;

                symbol1 = tilfældigtSymbol();
                symbol2 = tilfældigtSymbol();
                symbol3 = tilfældigtSymbol();

                nuværendeBoks = 1;
                gevinstTjekket = false;
                gevinstBesked = "";
                derErGevinst = false;
                spinSound.play();

                sidsteSpinTid = nuværendeTid;
            }
        }
    }
}
