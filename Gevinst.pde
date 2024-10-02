void tjekVinder() { 

// Variabel til gevinst-udgangspunktet
    int gevinst = 0;

// Hvis man får 3x bonus-symboler, skal det give 10.000x din indsats tilbage
    if (symbol1. getFilnavn().equals("bonus.png") && 
        symbol2.getFilnavn().equals("bonus.png") && 
        symbol3.getFilnavn().equals("bonus.png")) {
        gevinst = (int)(indsats * 10000);
    } 

// Hvis man får 2x bonus-symboler (uanset hvor), skal det give 20x din indsats tilbage
    else if ((symbol1.getFilnavn().equals("bonus.png") && symbol2.getFilnavn().equals("bonus.png")) || 
             (symbol1.getFilnavn().equals("bonus.png") && symbol3.getFilnavn().equals("bonus.png")) || 
             (symbol2.getFilnavn().equals("bonus.png") && symbol3.getFilnavn().equals("bonus.png"))) {
        gevinst = (int)(indsats * 20);
    } 

// Hvis alle tre symboler er ens skal den give hhv. 3x, 5.5x, 9x, 13x og 400x (samt afspille en jackpot-lyd hvis man får tre ens af jackpjerrot)
    else if (symbol1.getFilnavn().equals(symbol2.getFilnavn()) && symbol1.getFilnavn().equals(symbol3.getFilnavn())) {
        if (symbol1.getFilnavn().equals("candyfloss.png")) {
            gevinst = (int)(indsats * 3);
        } else if (symbol1.getFilnavn().equals("churros.png")) {
            gevinst = (int)(indsats * 5.5);
        } else if (symbol1.getFilnavn().equals("forlystelse.png")) {
            gevinst = (int)(indsats * 9);
        } else if (symbol1.getFilnavn().equals("turpas.png")) {
            gevinst = (int)(indsats * 13);
        } else if (symbol1.getFilnavn().equals("pjerrot.png")) {
            gevinst = (int)(indsats * 400);
            jackpjerrotSound.play();
        }
    } 

// Hvis de to første symboler er ens skal den give hhv. 1.4x, 2.3x, 3.2x, 4x og 9x
    else if (symbol1.getFilnavn().equals(symbol2.getFilnavn())) {
        if (symbol1.getFilnavn().equals("candyfloss.png")) {
            gevinst = (int)(indsats * 1.4);
        } else if (symbol1.getFilnavn().equals("churros.png")) {
            gevinst = (int)(indsats * 2.3);
        } else if (symbol1.getFilnavn().equals("forlystelse.png")) {
            gevinst = (int)(indsats * 3.2);
        } else if (symbol1.getFilnavn().equals("turpas.png")) {
            gevinst = (int)(indsats * 4);
        } else if (symbol1.getFilnavn().equals("pjerrot.png")) {
            gevinst = (int)(indsats * 9);
        }
    }

// Hvis gevinsten er over den fastsatte værdi (0), skal den tilføje gevinsten til saldoen, vise 'gevinstBesked'en og afspille 'winSound'-lyden
    if (gevinst > 0) {
        saldo += gevinst;
        derErGevinst = true;
        gevinstBesked = "Du vandt " + gevinst + " DKK";
        winSound.play();

// Hvis ikke der var gevinst, skal 'gevinstBesked'en forblive en tom String
    } else {
        gevinstBesked = "";
    
    }
}
