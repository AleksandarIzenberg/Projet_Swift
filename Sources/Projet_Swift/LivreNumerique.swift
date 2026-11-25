// Livre en version numérique : il a une taille de fichier en Mo
class LivreNumerique: Livre {
    let tailleFichierMo: Int

    init(titre: String, auteur: String, tailleFichierMo: Int) {
        self.tailleFichierMo = tailleFichierMo
        super.init(titre: titre, auteur: auteur)
    }

    override func afficherInformations() {
        super.afficherInformations()
        print("Type : Livre numérique | Taille du fichier : \(tailleFichierMo) Mo")
    }
}
