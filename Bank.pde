// Metode til at tegne bank-boksen, der viser spillerens saldo
void bank() {

    fill(255, 0, 0, 95);
    rect(230, 640, 410, 80);
    strokeWeight(3);
    stroke(0);
    fill(0);
    textSize(40);
    textAlign(LEFT, CENTER);
    text("SALDO: " + saldo + " DKK", 40, 640); // Tegn saldo-teksten på skærmen
    fill(255,255,50); // Skift farven til gul til at fremhæve saldo-teksten
    textSize(41);
    text("SALDO: " + saldo + " DKK", 36, 640); // Tegn saldo-teksten igen med den nye farve, lidt stroke-agtigt for effekt

}
