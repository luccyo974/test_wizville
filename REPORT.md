# Report

Mon premier commit avec le level 1
    j'ai mis plus de 2h (plutot 3) 
    j'ai passer (perdu?) beaucoup de temps a avoir un environnement fonctionnel
    afin de palier des soucis de rvm (pb avec openSSL sur les apple silicon) j'ai mis le projet sous docker.
    j'ai eu peu de temps du coup pour faire avancer le code.


    Quelque questions que je me suis posé: 
        il n'y a pas de priorisation des activities donc la prochaine sur la liste c'est vague, et ca peut être 2 niveau plus dur ou 2 niveau plus facile... ?
        l'"id" des activities n'est pas unique mais 'parait' unique si on prends le couple id/langue. l'id en question est-il que en Int, considerant que dans l'énnoncé on parle de uuid. (je l'ai donc reporté dans un champ uuid dans ma base.) ?
        
    j'ai estimé qu'un autre endpoint etait en charge de recevoir les resultat d'un activité et donc d'en créer la trace avec le score.
        un étudiant doit donc avec fini au moins une activité pour appeler le endpoint next_activity
    
    j'ai éstimé que le score parfait était 1

    les specs sont tres lights mais j'ai manqué de temps

    les modèles n'ont pas de validation (pour l'instant)

    Il faudrait envisager de gérer des exceptions custom pour les retours api

    j'ai découvert ActionController::API, jusque là je n'avais utilisé que grape pour les APIS
    je ne connais pas du tout postgre donc j'ai tout laissé de base


    launch : 
        server : docker compose run --service-ports rails
        console docker compose run console
        bash : docker compose run runner
            rails db:create, rails db:seed

QUESTION: les skills
    il n'est pas mentionné ques les activités suivante doivent suivre la skill de la dernière activité 
    pourtant cela peut paraitrait logique. 

Level 2
    rework des controller / et service
        il parassait plus logique de bouger les traitement dans le service plutot que des les laisser dans le controller

    QUESTION : si le critère du level 2 (activity_type != ) ramène des activité qui ne correspondent pas aux autre critères ??? En gros quelle sont les priorités dans les règles ??? comment prioriser les critères de recherche de la prochaine activité ???
        example de conflit de critères :
        - activites avec un niveau plus élevè malgré score < 1
        - activité uniquement précédente dans la liste malgré score = 1 


Level 3

    Ajout d'un champ 'has_microphone' à la table students
        QUESTION : quelle est la valeur par default de ce champ ? (actuellement à false)

level 4
    ajout d'un model skill (Skill (skillname, finished, activities_count, has_dicovery)), crées a chaque new skill decouvert avec un lien vers student (has_many :skills)


level 5
    Ajout d'un champ 'assignment' à la table students
        on s'appui sur la table acquired_skills pour gérer le nombre avant acquisition

    que fait on apres l'acuisition complète d'une skill ?
        et si le fallback default retourne la même skill encore ?


TODO
    add position on activity
    check all return if error
    