class Symboler {
    PImage billede;
    String filnavn;

    Symboler(String filnavn) {
        this.filnavn = filnavn;
        billede = loadImage(filnavn);
        billede.resize(275, 275);
    }

    PImage getBillede() {
        return billede;
    }

    String getFilnavn() {
        return filnavn;
    }
}

Symboler tilfældigtSymbol() {
    int totalWeight = 0;
    for (int weight : weights) {
        totalWeight += weight;
    }

    int randomValue = (int)(random(totalWeight));
    int cumulativeWeight = 0;

    for (int i = 0; i < weights.length; i++) {
        cumulativeWeight += weights[i];
        if (randomValue < cumulativeWeight) {
            return new Symboler(symbolFilnavne[i]);
        }
    }

    return new Symboler(symbolFilnavne[0]);
}
