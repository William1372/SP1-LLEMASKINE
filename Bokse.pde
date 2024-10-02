// Metode til at tegne det første symbol i midten af vinduet, forskudt til venstre
void boks1() {
    image(symbol1.getBillede(), width / 2 - 180 - symbol1.getBillede().width / 2, height / 2 - symbol1.getBillede().height / 2);
}

// Metode til at tegne det andet symbol i midten af vinduet
void boks2() {
    image(symbol2.getBillede(), width / 2 - symbol2.getBillede().width / 2, height / 2 - symbol2.getBillede().height / 2);
}

// Metode til at tegne det tredje symbol i midten af vinduet, forskudt til højre
void boks3() {
    image(symbol3.getBillede(), width / 2 + 180 - symbol3.getBillede().width / 2, height / 2 - symbol3.getBillede().height / 2);
}
