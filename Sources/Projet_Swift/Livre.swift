class Livre{
    private var titre : String
    private var auteur : String
    private var estDisponible : Int

    init(titre:String,auteur:String) {
        self.titre = titre
        self.auteur = auteur
        self.estDisponible = 1
    }

    public func getTitre()-> String{
        return titre
    }
    public func getAuteur()->String{
        return auteur
    }
    public func getDisponible()-> Int{
        return estDisponible
    }

    private func verifierDisponible() -> Bool {
    return estDisponible == 1
}

    public func afficherInformations(){
        print("Titre : \(titre) \n Auteur: \(auteur) \n Disponibilité : \(estDisponible)")
    }
    func emprunter(){
        if verifierDisponible() {
            estDisponible = 0
            print("Ce livre a été emprunté ")
        }else{
            print("Ce livre n'est pas disponible")
            
        }
    }
    func retourner(){
        if !verifierDisponible(){
            estDisponible = 1
            print("Ce livre a été rendu")
        }else{
            print("Ce livre est déjà rendu")
            
        }
    }

}
//sou klas liv yo sa ye
class LivrePapier:Livre{
    private var nombrePages : Int
    init(titre: String, auteur: String,nombrePages : Int) {
        self.nombrePages = nombrePages
        super.init(titre: titre, auteur: auteur)
    }
    override func afficherInformations() {
        print("Titre : \(getTitre()) \n Auteur: \(getAuteur()) \n Disponibilité : \(getDisponible())\n Nombre de Pages :\(nombrePages) \n")
    }
}

class LivreNumerique:Livre{
    private var tailleFichierMo : Int
    init(titre: String, auteur: String,tailleFichierMo : Int) {
        self.tailleFichierMo = tailleFichierMo
        super.init(titre: titre, auteur: auteur)
    }
    override func afficherInformations() {
        print("Titre : \(getTitre()) \n Auteur: \(getAuteur()) \n Disponibilité : \(getDisponible())\n Taille du fichier :\(tailleFichierMo) Mo \n")
    }
}

@MainActor
func EnregistrerLivre() {
    print("--- Enregistrement d'un livre ---")

    print("Combien de livre(s) voulez-vous enregistrer??")
    guard let nbb = readLine(), let nb=Int(nbb) else{
        print("Mauvaise entrée")
        return
    }
    for i in 1...nb {  
    
    print("Entrez le titre #\(i) : ")
    guard let titre = readLine(), !titre.isEmpty else {
        print("Aucun titre entré")
        return
    }
    
    print("Entrez l'auteur : ")
    guard let auteur = readLine(), !auteur.isEmpty else {
        print("Aucun auteur entré")
        return
    }
    print("Type de livre")
    print("1- Livre papier")
    print("2- Livre numérique")
    print("Votre choix : ", terminator: "")

    guard let choix = readLine(), let type = Int(choix) else {
        print("Choix invalide")
        return
    }

    switch type {
        case 1:
            print("Nombre de pages :")
            guard let pages = readLine(), let nombrePages = Int(pages) else {
                print("Nombre de pages invalide")
                return
            }

            let livre = LivrePapier(
                titre: titre,
                auteur: auteur,
                nombrePages: nombrePages
            )
            bibliotheque.ajouterLivre(livre)

        case 2:
            print("Taille du fichier en Mo :")
            guard let taille = readLine(), let tailleMo = Int(taille) else {
                print("Taille invalide")
                return
            }

            let livre = LivreNumerique(
                titre: titre,
                auteur: auteur,
                tailleFichierMo: tailleMo
            )
            bibliotheque.ajouterLivre(livre)

        default:
            print("Type de livre invalide")
        }
        
    }
}
