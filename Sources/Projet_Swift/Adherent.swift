// Un adhérent peut emprunter au maximum 3 livres
class Adherent {
    let nom: String
    private(set) var livresEmpruntes: [Livre] = []
    private let maximumEmprunts = 3

    init(nom: String) {
        self.nom = nom
    }

    func emprunterLivre(_ livre: Livre) {
        if livresEmpruntes.count >= maximumEmprunts {
            print("\(nom) a déjà emprunté \(maximumEmprunts) livres. Emprunt refusé.")
            return
        }

        if livre.emprunter() {
            livresEmpruntes.append(livre)
            print("\(nom) a emprunté \"\(livre.titre)\".")
        } else {
            print("Le livre \"\(livre.titre)\" n'est pas disponible.")
        }
    }

    func retournerLivre(_ livre: Livre) {
        // on cherche le livre dans la liste des emprunts
        if let position = livresEmpruntes.firstIndex(where: { $0 === livre }) {
            livresEmpruntes.remove(at: position)
            livre.retourner()
            print("\(nom) a retourné \"\(livre.titre)\".")
        } else {
            print("\(nom) n'a pas emprunté \"\(livre.titre)\".")
        }
    }

    func afficherEmprunts() {
        print("Livres empruntés par \(nom) :")
        if livresEmpruntes.isEmpty {
            print("Aucun livre emprunté.")
            return
        }
        for livre in livresEmpruntes {
            livre.afficherInformations()
            print("-------------------")
        }
    }
}
