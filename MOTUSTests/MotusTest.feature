# language: fr
Fonctionnalité: Motus

    Scénario: Calculer la correspondance d'un mot
        Étant donné que Le mot candidat est "<Candidat>"
        Et    La reponse est "<Reponse>"
        Quand L'évaluation est "<Evaluation>"
        Alors La correspondance est "<Correspondance>"
    Exemples:
        | Candidat   | Reponse  | Evaluation    | Correspondance    |
        | DAGUE      | DAGUE    | 22222         | OUI               |
        | DAGUE      | BOBAK    | 00010         | OUI               |
        | DAGUE      | BOBAK    | 00020         | NON               |
        | PELLE      | BELLE    | 02200         | NON               |
        | PELLE      | BELLE    | 02222         | OUI               |
        | PELVL      | BELLE    | 02210         | OUI               |
        | PELVL      | BELLV    | 02210         | NON               |
        | PELVL      | BELLE    | 02211         | NON               |
        | PCCEL      | BELLE    | 01100         | OUI               |
        | ILEAL      | BELLE    | 01100         | NON               |
        | DAGUE      | DAGUE    | 32222         | NON               |
        
    Scénario: Calculer le nombre de mots correspondants
        Étant donné que Le dictionnaire "Lexique_DOUBLELETTRE" est chargé
        Et Le mot tenté est "<MotTente>"
        Quand La correspondance évalué est "<correspondance>"
        Alors Le nombre de mot correspondant est "<nombreCorrespondant>"
    Exemples:
        | MotTente | correspondance | nombreCorrespondant    |
        | BELLE    | 00200          | 1                      |
        | BELLE    | 00220          | 2                      |

    Scénario: Proposer le mot optimal sur 100 mots
        Étant donné que Le dictionnaire "Lexique_100" est chargé
        Quand Je veux avoir le mot avec le plus de correspondance moyenne
        Alors Le mot proposé est "SOUTE"
        
    Scénario: Ne pas proposer le mot optimal si la liste de mots est vide
        Étant donné que Le dictionnaire "Lexique_Vide" est chargé
        Quand Je veux avoir le mot avec le plus de correspondance moyenne
        Alors Le mot proposé est "AUCUNE PROPOSITION"

    Scénario: Proposer le mot optimal sur le Lexique de WORDLE FR après plusieurs tentatives
        Étant donné que Le dictionnaire "Lexique_WORDLE_FR" est chargé
        Et La reponse essayée est "RAIES" avec comme résultat "02022"
        Et La reponse essayée est "LAMES" avec comme résultat "02022"
        Quand Je veux avoir le mot avec le plus de correspondance moyenne
        Alors Le mot proposé est "TAPES"

    Scénario: Proposer le mot optimal sur le Lexique de WORDLE EN après plusieurs tentatives
        Étant donné que Le dictionnaire "Lexique_WORDLE_EN" est chargé
        Et La reponse essayée est "IDLES" avec comme résultat "00100"
        Et La reponse essayée est "LOURY" avec comme résultat "11000"
        Et La reponse essayée est "GLOOP" avec comme résultat "02200"
        Et La reponse essayée est "FLOTA" avec comme résultat "02220"
        Quand Je veux avoir le mot avec le plus de correspondance moyenne
        Alors Le mot proposé est "CLOTH"
