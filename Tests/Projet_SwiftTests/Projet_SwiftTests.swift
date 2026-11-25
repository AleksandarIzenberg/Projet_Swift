import Testing
@testable import Projet_Swift

@Test func empruntDunLivreDisponible() {
    let livre = Livre(titre: "Titre", auteur: "Auteur")
    #expect(livre.emprunter() == true)
    #expect(livre.estDisponible == false)
}

@Test func empruntDunLivreDejaEmprunte() {
    let livre = Livre(titre: "Titre", auteur: "Auteur")
    _ = livre.emprunter()
    #expect(livre.emprunter() == false)
}

@Test func retourDunLivre() {
    let livre = Livre(titre: "Titre", auteur: "Auteur")
    _ = livre.emprunter()
    livre.retourner()
    #expect(livre.estDisponible == true)
}

@Test func adherentEmpruntePuisRetourne() {
    let adherent = Adherent(nom: "Test")
    let livre = Livre(titre: "Titre", auteur: "Auteur")
    adherent.emprunterLivre(livre)
    #expect(adherent.livresEmpruntes.count == 1)
    adherent.retournerLivre(livre)
    #expect(adherent.livresEmpruntes.count == 0)
    #expect(livre.estDisponible == true)
}

@Test func adherentLimiteDeTroisLivres() {
    let adherent = Adherent(nom: "Test")
    for i in 1...4 {
        adherent.emprunterLivre(Livre(titre: "Livre \(i)", auteur: "Auteur"))
    }
    #expect(adherent.livresEmpruntes.count == 3)
}

@Test func rechercheParTitre() {
    let biblio = Bibliotheque()
    biblio.ajouterLivre(Livre(titre: "Swift", auteur: "Auteur"))
    #expect(biblio.rechercherLivre(titre: "swift") != nil)
    #expect(biblio.rechercherLivre(titre: "Inconnu") == nil)
}
