# language: fr
Fonctionnalité: Motus

    Scénario: Calculer la correspondance d'un mot
        Étant donné que Le mot candidat est "<Candidat>"
        Et    La reponse est "<Reponse>"
        Quand Levaulation est "<Evaluation>"
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

    Scénario: Proposer le mot optimal sur le Lexique de WORDLE
        Étant donné que Le dictionnaire "Lexique_WORDLE" est chargé
        Quand Je veux avoir le mot avec le plus de correspondance moyenne
        Alors Le mot proposé est "RAIES"

    Scénario: Proposer le mot optimal sur le Lexique de WORDLE après plusieurs tentatives
        Étant donné que Le dictionnaire "Lexique_WORDLE" est chargé
        Et La reponse essayée est "RAIES" avec comme résultat "02022"
        Et La reponse essayée est "LAMES" avec comme résultat "02022"
        Quand Je veux avoir le mot avec le plus de correspondance moyenne
        Alors Le mot proposé est "TAPES"

