class Symboler {

// Instansvariabler til klassen, der repræsenterer et symbol
    PImage billede; // Billedet af symbolet
    String filnavn; // Filnavnet på symbolet

// Konstruktør, der tager et filnavn som parameter og indlæser symbolet
    Symboler(String filnavn) {
        this.filnavn = filnavn; 
        billede = loadImage(filnavn); // Indlæser billedet fra filnavnet
        billede.resize(275, 275); // Resizer størrelsen på symbolerne
    }

// Getter-metode til at returnere billedet
    PImage getBillede() {
        return billede;
    }

// Getter-metode til at returnere filnavnet
    String getFilnavn() {
        return filnavn;
    }
}

// Metode til at generere et tilfældigt symbol baseret på vægtfordelingen
Symboler tilfældigtSymbol() {
    int totalWeight = 0;

// Beregn den samlede vægt ved at summere alle vægte
    for (int weight : weights) {
        totalWeight += weight;
    }

// Generer et tilfældigt tal mellem 0 og totalWeight
    int randomValue = (int)(random(totalWeight));
    int cumulativeWeight = 0;

// Find det symbol, der svarer til den tilfældige værdi ved hjælp af vægtfordelingen
    for (int i = 0; i < weights.length; i++) {
        cumulativeWeight += weights[i]; // Opdater den kumulative vægt
        if (randomValue < cumulativeWeight) { // Hvis den tilfældige værdi er mindre end cumulativeWeight
            return new Symboler(symbolFilnavne[i]); // Returner symbolet
        }
    }

// Som en slags sikkerhedsforanstaltning, returner det første symbol, hvis ingen matches (burde aldrig ske og er ikke sket endnu :-))
    return new Symboler(symbolFilnavne[0]);

}
