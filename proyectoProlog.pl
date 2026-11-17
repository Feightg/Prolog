
% ==========================================================
% PROYECTO FINAL LOGICA
% Sistema de recomendacion de peliculas
% Hecho por:    Alfredo Zamorano Rodriguez
%               Malillani flores Tejada
%               Antonio 
%               Uzziel           
% ==========================================================
:- use_module(library(readutil)).   
% ==========================================================
% 1. PREGUNTAS Y OPCIONES
% ==========================================================

% Cada pregunta tiene un identificador, un mensaje y una
% lista de respuestas posibles.

pregunta(genero,
    'Que genero de pelicula prefieres?',
    [accion, ciencia_ficcion, terror, comedia, drama, animacion]).

pregunta(duracion,
    'Que duracion prefieres?',
    [corta, media, larga]).

pregunta(epoca,
    'De que epoca prefieres la pelicula?',
    [clasica, moderna, reciente, indiferente]).

pregunta(tono,
    'Que ambiente buscas?',
    [ligero, intenso, oscuro, emotivo]).

pregunta(animacion,
    'Te gustan las peliculas animadas?',
    [si, no]).

pregunta(saga,
    'Te gustan las peliculas que pertenecen a una saga?',
    [si, no]).

pregunta(idioma,
    'Que idioma prefieres?',
    [espanol, ingles, indiferente]).

pregunta(ritmo,
    'Que ritmo prefieres?',
    [rapido, tranquilo, confuso]).


% ==========================================================
% 2. MOSTRAR OPCIONES
% ==========================================================

% Muestra las opciones numeradas mediante recursividad.

mostrar_opciones([], _).

mostrar_opciones([Opcion|Resto], Numero) :-
    format('  ~w. ~w~n', [Numero, Opcion]),
    Siguiente is Numero + 1,
    mostrar_opciones(Resto, Siguiente).


% ==========================================================
% 3. VALIDACION DE RESPUESTAS
% ==========================================================

% Comprueba que el usuario introduzca un numero valido.

leer_opcion(Opciones, Respuesta) :-
    repeat,
    read_line_to_string(user_input, Entrada),
    (   Entrada \= end_of_file,
        number_string(Numero, Entrada),
        integer(Numero),
        nth1(Numero, Opciones, Respuesta)
    ->  !
    ;   writeln('Opcion no valida. Intenta nuevamente:'),
        fail
    ).


% ==========================================================
% 4. REALIZAR PREGUNTAS
% ==========================================================    

% Presenta una pregunta y obtiene una respuesta valida.

hacer_pregunta(Id, Respuesta) :-
    pregunta(Id, Texto, Opciones),
    nl,
    writeln(Texto),
    mostrar_opciones(Opciones, 1),
    write('Selecciona una opcion: '),
    leer_opcion(Opciones, Respuesta).


% ==========================================================
% 5. RECOLECCION DE RESPUESTAS
% ==========================================================

% Realiza las ocho preguntas y almacena las respuestas
% en una lista de opciones.

obtener_respuestas(Respuestas) :-
    hacer_pregunta(genero, Genero),
    hacer_pregunta(duracion, Duracion),
    hacer_pregunta(epoca, Epoca),
    hacer_pregunta(tono, Tono),
    hacer_pregunta(animacion, Animacion),
    hacer_pregunta(saga, Saga),
    hacer_pregunta(idioma, Idioma),
    hacer_pregunta(ritmo, Ritmo),

    Respuestas = [
        Genero,
        Duracion,
        Epoca,
        Tono,
        Animacion,
        Saga,
        Idioma,
        Ritmo
    ].


% ==========================================================
% 6. REGLAS DE RECOMENDACION
% ==========================================================

% Cada regla relaciona las preferencias del usuario con
% una pelicula y una explicacion.

recomendar(
    [terror, _, _, oscuro, _, _, _, _],
    'Hereditary',
    'Elegiste terror y un ambiente oscuro. Esta pelicula destaca por su atmosfera inquietante.'
).

recomendar(
    [terror, larga, moderna, intenso, _, _, ingles, tranquilo],
    'El conjuro 3',
    'Buscas terror intenso, con una historia larga y actual, en ingles, y esta pelicula ofrece una experiencia unica en su clase'
).

recomendar(
    [ciencia_ficcion, larga, moderna, intenso, _, _, ingles, confuso],
    'Interestelar',
    'Buscas ciencia ficcion, una historia larga e intensa. Esta pelicula combina exploracion espacial y drama.'
).

recomendar(
    [accion, _, _, intenso, _, si, _, rapido],
    'Mad Max: Fury Road',
    'Prefieres accion intensa, ritmo rapido y peliculas de saga. Esta pelicula ofrece accion constante.'
).

recomendar(
    [comedia, _, _, ligero, _, _, _, _],
    'Superbad',
    'Buscas una comedia ligera. Esta pelicula ofrece una historia divertida y desenfadada.'
).

recomendar(
    [drama, larga, _, emotivo, _, _, _, tranquilo],
    'Sueños de fuga',
    'Prefieres un drama largo y emotivo con un ritmo tranquilo. Esta pelicula ofrece una historia profunda.'
).

recomendar(
    [animacion, _, _, _, si, _, espanol, _],
    'Coco',
    'Te gusta la animacion y prefieres el español. Esta pelicula combina musica, familia y emocion.'
).

recomendar(
    [animacion, _, _, _, si, _, _, _],
    'Spider-Man: Un nuevo universo',
    'Te gustan las peliculas animadas. Esta pelicula destaca por su estilo visual y accion.'
).

recomendar(
    [drama, _, clasica, _, _, _, _, _],
    'El padrino',
    'Prefieres los dramas clasicos. Esta pelicula es una historia de crimen y familia.'
).

recomendar(
    [ciencia_ficcion, _, _, _, _, _, _, _],
    'Matrix',
    'Te interesa la ciencia ficcion. Esta pelicula combina accion con ideas filosoficas.'
).

% Recomendaciones alternativas segun el genero.

recomendar(
    [accion, _, _, _, _, _, _, _],
    'John Wick',
    'Buscas accion. Esta pelicula ofrece combates y un ritmo dinamico.'
).

recomendar(
    [terror, _, _, _, _, _, _, _],
    'El conjuro',
    'Te interesa el terror. Esta pelicula ofrece suspenso y elementos sobrenaturales.'
).

recomendar(
    [comedia, _, _, _, _, _, _, _],
    'La mascara',
    'Buscas entretenimiento y comedia. Esta pelicula combina humor y fantasia.'
).

recomendar(
    [drama, _, _, _, _, _, _, _],
    'Forrest Gump',
    'Te interesa el drama. Esta pelicula cuenta una historia emotiva a lo largo de varias decadas.'
).

recomendar(
    [animacion, _, _, _, _, _, _, _],
    'Shrek',
    'Te interesa la animacion. Esta pelicula combina humor y aventura.'
).

% ==========================================================
% 7. MOSTRAR RESULTADO
% ==========================================================

% Obtiene una recomendacion a partir de las respuestas.

mostrar_recomendacion(Respuestas) :-
    recomendar(Respuestas, Pelicula, Explicacion),
    nl,
    writeln('========================================'),
    writeln('       TU RECOMENDACION DE HOY'),
    writeln('========================================'),
    format('Pelicula: ~w~n', [Pelicula]),
    format('Motivo: ~w~n', [Explicacion]),
    writeln('========================================').


% ==========================================================
% 8. PREDICADO PRINCIPAL
% ==========================================================

% Inicia el sistema completo.

inicio :-
    nl,
    writeln('========================================'),
    writeln('   SISTEMA DE RECOMENDACION DE PELICULAS'),
    writeln('========================================'),
    writeln('Responde las siguientes preguntas.'),
    writeln('Escribe el numero de la opcion deseada.'),

    obtener_respuestas(Respuestas),

    mostrar_recomendacion(Respuestas),

    writeln('Gracias por utilizar nuestro sistema.').

% ==========================================================
% FIN DEL PROGRAMA
% ==========================================================
