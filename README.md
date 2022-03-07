# Motus - ⬛🟩🟩🟧⬛ - [![MOTUS](https://github.com/benjsei/Motus/actions/workflows/motus.yml/badge.svg)](https://github.com/benjsei/Motus/actions/workflows/motus.yml) - [![codecov](https://codecov.io/gh/benjsei/Motus/branch/master/graph/badge.svg?token=RM6QETZD2C)](https://codecov.io/gh/benjsei/Motus)

Algorithme pour tricher à Wordle 😉, développé en SWIFT et FullBDD.

Inspiré par l'article et la vidéo de la 😍 chaîne YouTube de Science Etonnante : https://www.youtube.com/watch?v=iw4_7ioHWF4&t=1s
Elle-même inspirée de 😍 3Blue1Brown : https://www.youtube.com/watch?v=v68zYyaEmEA&t=0s

# Fonctionnalités

## Règle 1 : Evaluer si un mot (candidat) correspond (✅) ou pas (❌) par rapport à un mot donné (Reponse) et à une évaluation lettre par lettre (🟩🟧⬛).

### Scénario: Calculer la correspondance d'un mot
        Étant donné que Le mot candidat est "<Candidat>"
        Et    La reponse est "<Reponse>"
        Quand Levaulation est "<Evaluation>"
        Alors La correspondance est "<Correspondance>"
    Exemples:
        | Candidat   | Reponse  | Evaluation  | Correspondance   |
        | DAGUE      | DAGUE    | 🟩🟩🟩🟩🟩    | ✅               |
        | DAGUE      | BOBAK    | ⬛⬛⬛🟧⬛    | ✅               |
        | DAGUE      | BOBAK    | ⬛⬛⬛🟩⬛    | ❌               |
        | PELLE      | BELLE    | ⬛🟩🟩⬛⬛    | ❌               |
        | PELLE      | BELLE    | ⬛🟩🟩🟩🟩    | ✅               |
        | PELVL      | BELLE    | ⬛🟩🟩🟧⬛    | ✅               |
        | PELVL      | BELLV    | ⬛🟩🟩🟧⬛    | ❌               |
        | PELVL      | BELLE    | ⬛🟩🟩🟧🟧    | ❌               |
        | PCCEL      | BELLE    | ⬛🟧🟧⬛⬛    | ✅               |
        | ILEAL      | BELLE    | ⬛🟧🟧⬛⬛    | ❌               |

 ## Règle 2: Compter le nombre de mots correspondants (✅) dans une liste de mots par rapport à un mot donné (MotTente) et à une évaluation lettre par lettre (🟩🟧⬛).
       
 ### Scénario: Calculer le nombre de mots correspondants
        Étant donné que Le dictionnaire "Lexique_DOUBLELETTRE" est chargé
        Et Le mot tenté est "<MotTente>"
        Quand La correspondance évaluée est "<correspondance>"
        Alors Le nombre de mot correspondant est "<nombreCorrespondant>"
    Exemples:
        | MotTente | correspondance  | nombreCorrespondant    |
        | BELLE    | ⬛⬛🟩⬛⬛        | 1                      |
        | BELLE    | ⬛⬛🟩🟩⬛        | 2                      |

## Règle 3: Donner le mot ayant la plus grande entropie par rapport à une liste de mots. L'Entropie étant sa faculter à couper au mieux en 2 parts "égales" la liste de mots d'origine.
 
### Scénario: Proposer le mot optimal sur 100 mots
        Étant donné que Le dictionnaire "Lexique_100" est chargé
        Quand Je veux avoir le mot avec le plus de correspondance moyenne
        Alors Le mot proposé est "SOUTE"

### Scénario: Proposer le mot optimal sur le Lexique de WORDLE FR
        Étant donné que Le dictionnaire "Lexique_WORDLE_FR" est chargé
        Quand Je veux avoir le mot avec le plus de correspondance moyenne
        Alors Le mot proposé est "RAIES"

## Règle 4: Filtrer la liste des mots en fonction d'un mot et de son évaluation pour réduire les possibilités. Et donner le mot ayant la plus grande entropie de la liste de mots restants. 
 
### Scénario: Proposer le mot optimal sur le Lexique de WORDLE FR après plusieurs tentatives
        Étant donné que Le dictionnaire "Lexique_WORDLE_FR" est chargé
        Et La reponse essayée est "RAIES" avec comme résultat "⬛🟩⬛🟩🟩"
        Et La reponse essayée est "LAMES" avec comme résultat "⬛🟩⬛🟩🟩"
        Quand Je veux avoir le mot avec le plus de correspondance moyenne
        Alors Le mot proposé est "TAPES"

### Scénario: Proposer le mot optimal sur le Lexique de WORDLE EN après plusieurs tentatives
        Étant donné que Le dictionnaire "Lexique_WORDLE_EN" est chargé
        Et La reponse essayée est "IDLES" avec comme résultat "⬛⬛🟧⬛⬛"
        Et La reponse essayée est "LOURY" avec comme résultat "🟧🟧⬛⬛⬛"
        Et La reponse essayée est "GLOOP" avec comme résultat "⬛🟩🟩⬛⬛"
        Et La reponse essayée est "FLOTA" avec comme résultat "⬛🟩🟩🟩⬛"
        Quand Je veux avoir le mot avec le plus de correspondance moyenne
        Alors Le mot proposé est "CLOTH"
