void tjekVinder() {    
    int gevinst = 0;
    
    if (symbol1. getFilnavn().equals("bonus.png") && 
        symbol2.getFilnavn().equals("bonus.png") && 
        symbol3.getFilnavn().equals("bonus.png")) {
        gevinst = (int)(indsats * 10000);
    } 
    
    else if ((symbol1.getFilnavn().equals("bonus.png") && symbol2.getFilnavn().equals("bonus.png")) || 
             (symbol1.getFilnavn().equals("bonus.png") && symbol3.getFilnavn().equals("bonus.png")) || 
             (symbol2.getFilnavn().equals("bonus.png") && symbol3.getFilnavn().equals("bonus.png"))) {
        gevinst = (int)(indsats * 20);
    } 
    
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

    if (gevinst > 0) {
        saldo += gevinst;
        derErGevinst = true;
        gevinstBesked = "Du vandt " + gevinst + " DKK";
        winSound.play();
    } else {
        gevinstBesked = "";
    
    }
}
