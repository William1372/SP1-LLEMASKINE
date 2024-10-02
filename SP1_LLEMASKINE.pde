// Importerer Processings lyd bibliotek, der gør det muligt at afspille lydfiler. Jeg har valgt .wav lydfiler, da de oftest har bedre lydkvalitet end .mp3 (dog fylder de ofte også mere)
import processing.sound.*;
// Variabler til at holde de forskellige billeder, eksempelvis baggrund, knapper og andre elementer
PImage img, dæmonenImg, infoImage, startScreenImg, spinoginfo, bonusBeskedImg, lukInfo;
// Instanser af 'Symboler'-klassen, som repræsenterer symbolerne i spillet
Symboler symbol1, symbol2, symbol3;
// Styrer om symbolerne skal vises, om startskærmen skal vises og/eller om infoskærmen vises
boolean visBokse = false, showStartScreen = true, showInfo = false;
// Variabler til tidsstyring, herunder interval for at vise symboler, tid til at vise gevinstbesked og 'spin-cooldown'
int nuværendeBoks = 1, opdateringsTid = 0, interval = 1000,  startTid = 0, gevinstTid = 0,
gevinstVisningTid = 0, gevinstVisningVarighed = 1000, sidsteSpinTid = 0, spinCooldown = 3000;
// Variabler, der sætter (start)saldoen til den angivne int, samme for indsatsen - begge er dynamiske 
int saldo = 1000, indsats = 2;
// Variabler til at tjekke; om gevinsten er blevet tjekket, om der er gevinst og/eller om saldoen er for lav
boolean gevinstTjekket = false, derErGevinst = false, lavSaldo = false;
// String variabel til at kontrollerer, at gevinstbeskeden som udgangspunkt ikke skal indeholde noget
String gevinstBesked = "";
// Variabler til at holde på de diverse lydfiler; eksempelvis når man får gevinst afspilles 'winSound' osv.
SoundFile spinSound, winSound, jackpjerrotSound, backgroundMusic;
// Variabler til at holde på den font jeg har valgt - bruges bl.a. ved saldo og indsats (grunden til, at der er to er, at de er to forskellige størrelser; men man behøver sikkert kun én)
PFont myFont, myFont2;
// En array, der holder på de diverse symbolers billedfiler
String[] symbolFilnavne = {"candyfloss.png", "churros.png", "forlystelse.png", "turpas.png", "pjerrot.png", "bonus.png"}; 
// Procentfordeling/vægtfordelingen for de diverse symboler fra arrayen (chance)
int[] weights = {30, 25, 17, 15, 10, 3};

void setup() {
// Sætter størrelsen på programmets vindue til 1280, 720 pixels
    size(1280, 720);

// Loader baggrundsbilledet og resizer det til vinduets størrelse (1280, 720)
    img = loadImage("tivoli_baggrund.jpg");
    img.resize(1280, 720);
// Loader billeder til baggrund og knapper
    dæmonenImg = loadImage("dæmonen.png");
    bonusBeskedImg = loadImage("bonusbesked.png");
    infoImage = loadImage("info.png");
    startScreenImg = loadImage("startscreen.png");
    spinoginfo = loadImage("spinoginfo.png");
    lukInfo = loadImage("lukInfo.png");
// Opretter fonts med forskellige størrelse
    myFont = createFont("Bungee_Inline.ttf", 30);
    myFont2 = createFont("Bungee_Inline.ttf", 20);
// Loader lydfiler til forskellige handlinger; bl.a. spin, gevinst og jackpot
    spinSound = new SoundFile(this, "spinSound.wav");
    winSound = new SoundFile(this, "winSound.wav");
    jackpjerrotSound = new SoundFile(this, "jackpjerrot.wav");
    backgroundMusic = new SoundFile(this, "backgroundMusic.wav");
// Sørger for, at baggrundsmussiken looper kontinuerligt
    backgroundMusic.loop();

// CENTER-mode så rektangler og billeder centrerer omkring deres position
    rectMode(CENTER);
    imageMode(CENTER);
   
}

void draw() {
// Hvis 'showStartScreen' er true, vises startskærmbilledet (startScreenImg) og skjuler baggrunden
    if (showStartScreen) {

        background(0);
        image(startScreenImg, width / 2, height / 2);

    } else {
// Hvis 'showStartScreen' er false, vises spillets indhold (baggrundsbillede, dæmonbillede, knapper, bokse/rects)
        background(img);
        image(dæmonenImg, width / 2, 380);
        image(spinoginfo, width / 2, height / 2+15);
        image(bonusBeskedImg, width/2, height - 367);
        
        fill(195, 0, 0, 97);
        rect(width / 2, height / 2, 1080, 440);

// Boksen og teksten for indsatsen (dynamisk)
        fill(255, 0, 0, 97);
        rect(width - 240, height - 50, 200, 40);
        fill(0);
        textAlign(CENTER, CENTER);
        textFont(myFont);
        text(indsats + " DKK", width - 220, height - 50);
        fill(255, 255, 0);
        textSize(29);
        text(indsats + " DKK", width - 220, height - 50);

// Statisk tekst "INDSATS" ved siden af indsatsboksen (ovenstående)
        fill(255, 0, 0, 97);
        rect(width - 240, height - 90, 200, 40);
        fill(0);
        textFont(myFont);
        text("INDSATS", width - 240, height - 90);
        fill(255, 255, 0);
        textSize(29);
        text("INDSATS", width - 240, height - 90);
// Sørger for at 'bank'-metoden kører
        bank();

// Hvis man spinner (visBokse er true) - og 'spin-cooldown' er ovre - 'spinner' symbolerne
        if (visBokse) {
            if (millis() - opdateringsTid > interval) {
                opdateringsTid = millis();
                nuværendeBoks++;
            }
// Sætter farverne på boksene (bag symbolerne) til hvid med en 150 opacitet
            color firkant1Farve = color(255, 255, 255, 150);
            color firkant2Farve = color(255, 255, 255, 150);
            color firkant3Farve = color(255, 255, 255, 150);

// Hvis nuværendeBoks er 2 (eller over), og symbol2 matcher symbol1, skift farverne bag symbolerne til grøn med 150 opacitet
            if (nuværendeBoks >= 2 && symbol2.getFilnavn().equals(symbol1.getFilnavn())) {
                firkant1Farve = color(0, 255, 0, 150);
                firkant2Farve = color(0, 255, 0, 150);
            }
// Hvis nuværendeBoks er 3 (eller over), og symbol2 matcher symbol1, skift farverne bag symbolerne til grøn med 150 opacitet
            if (nuværendeBoks >= 3 && symbol3.getFilnavn().equals(symbol2.getFilnavn()) && symbol2.getFilnavn().equals(symbol1.getFilnavn())) {
                firkant3Farve = color(0, 255, 0, 150);
            }
// Når nuværendeBoks er 1 eller mere, vis boksen (hvid) bag det første symbol, der genereres med 'getBillede'
            if (nuværendeBoks >= 1) {
                fill(firkant1Farve);
                rect(width / 4, height / 2, 200, 200);
                image(symbol1.getBillede(), width / 4, height / 2);
            }
// Når nuværendeBoks er 2 eller mere, vis boksen (hvid) bag det andet symbol
            if (nuværendeBoks >= 2) {
                fill(firkant2Farve);
                rect(width / 2, height / 2, 200, 200);
                image(symbol2.getBillede(), width / 2, height / 2);
            }
// Når nuværendeBoks er 3, vis boksen (hvid) bag det tredje symbol
            if (nuværendeBoks >= 3) {
                fill(firkant3Farve);
                rect(width * 3 / 4, height / 2, 200, 200);
                image(symbol3.getBillede(), width * 3 / 4, height / 2);
// Når boks 3 er vist, tjek om der er gevinst ved hjælp af 'tjekVinder'-metoden
                if (!gevinstTjekket) {
                    tjekVinder();
                    gevinstTjekket = true;
                }
            }
// Hvis 'gevinstTjekket' bliver true efter ovenstående kode, skal den vise 'gevinstBesked'
            if (derErGevinst) {
              
                fill(0);
                textSize(64);
                textAlign(CENTER, CENTER);
                text(gevinstBesked, width / 2 + 2, height / 2 + 2);
                fill(0, 255, 0);
                text(gevinstBesked, width / 2, height / 2);
                
            }
            
        }
// Hvis der er gevinst, vises 'gevinstBesked' på skærmen
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
// Hvis man trykker på '?'-knappen, vises info-billedet, ellers skjules det 
                if (showInfo) {
        
        image(infoImage, width / 2, height / 2, 1180, 620);
        image(lukInfo, width / 2, height / 2, 1280, 720);
        }
    }
}
// User inputs med mellemrum, 'u' og 'i'
void keyPressed() {
//  Hvis der trykkes og 'showStartScreen' er true, skal den gøres false (altså skjule startskærmen)
    if (showStartScreen) {
        showStartScreen = false;
        return;
    }
// Hvis der trykkes 'i' (indsats op), skal indsatsen stige med 2
    if (key == 'i') {
        indsats += 2;
// Hvis indsatsen overstiger 100, sættes den tilbage til 2
    if (indsats > 100) {
        indsats = 2;
    }
} 
// Hvis der trykkes 'u' (indsats ned), skal indsatsen falde med 2
else if (key == 'u') { // Ændret til else if for at undgå forkert nestet if
    indsats -= 2;
    // Hvis indsatsen falder under 2, sættes den tilbage til 2
    if (indsats < 2) {
        indsats = 2;
    }
}
/* Hvis man trykker mellemrum og 'spinCooldown' er ovre, skal den visBokse (spinne symbolerne), 'nulstille' opdateringsTid, fratrække indsatsen fra saldoen,
   afspille spinSound, tjekke om der er gevinst og evt. vise gevinstBeskeden */
    int nuværendeTid = millis(); 
     if (key == ' ' && nuværendeTid - sidsteSpinTid >= spinCooldown) {
        if (saldo >= indsats) {
            spinSound.play(); // Afspil 'spinSound'-lydfilen
            visBokse = true; // Begynd at vise symbolerne
            opdateringsTid = millis(); // Nulstil opdaterings tiden
            saldo -= indsats; // Fratræk indsatsen fra saldoen

// Tildel tilfældige symboler til variablerne
            symbol1 = tilfældigtSymbol();
            symbol2 = tilfældigtSymbol();
            symbol3 = tilfældigtSymbol();

            nuværendeBoks = 1; // Nulstil boks tælleren
            gevinstTjekket = false; // Nulstil gevinst tjek
            gevinstBesked = ""; // Tøm gevinstbeskeden
            derErGevinst = false; // Ingen gevinst ved spin

            sidsteSpinTid = nuværendeTid; // Opdater tiden for det sidste spin
        }
    }
}

// Hvis der trykkes med musen og 'showStartScreen' er true, skal den gøres false (altså skjule startskærmen)
void mousePressed() {
    if (showStartScreen) {
        showStartScreen = false;
        return;
    }
// Hvis man trykker på selve indsatsen skal den stige med 2
    if (mouseX >= width - 310 && mouseX <= width - 120 && mouseY >= height - 90 && mouseY <= height - 50) {
        indsats += 2;
// Hvis indsatsen overstiger 100, skal den nulstilles til 2
        if (indsats > 100) {
            indsats = 2;
        }
    }

// Hvis man trykker på '?'-knappen, vises info-skærmen
    if (dist(mouseX, mouseY, width - 50, height - 80) < 37.5) {
        showInfo = !showInfo;
    }

// Samme funktionalitet som mellemrum, når 'spin'-knappen trykkes
    int nuværendeTid = millis();
    if (nuværendeTid - sidsteSpinTid >= spinCooldown) {
        if (dist(mouseX, mouseY, width / 2, height - 80) < 100) {
            if (saldo >= indsats) {

                spinSound.play(); // Afspil 'spinSound'-lydfilen
                visBokse = true; // Begynd at vise symbolerne
                opdateringsTid = millis(); // Nulstil opdaterings tiden
                saldo -= indsats; // Fratræk indsatsen fra saldoen

// Tildel tilfældige symboler til variablerne
                symbol1 = tilfældigtSymbol();
                symbol2 = tilfældigtSymbol();
                symbol3 = tilfældigtSymbol();

                nuværendeBoks = 1; // Nulstil boks tælleren
                gevinstTjekket = false; // Nulstil gevinst tjek
                gevinstBesked = ""; // Tøm gevinstbeskeden
                derErGevinst = false; // Ingen gevinst ved spin

                sidsteSpinTid = nuværendeTid; // Opdater tiden for det sidste spin
            }
        }
    }
}
