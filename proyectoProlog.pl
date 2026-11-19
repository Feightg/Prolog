
% ==========================================================
% PROYECTO FINAL LOGICA
% Sistema de recomendacion de peliculas
%               Universidad Veracruzana
% Hecho por:    Alfredo Zamorano Rodriguez
%               Malillani flores Tejada
%               Jose Antonio Leyva Galindo
%               Uzziel Aquino Ramos         
% ==========================================================
:- use_module(library(readutil)).   
% ==========================================================
% 1. PREGUNTAS Y OPCIONES
% ==========================================================

% Cada pregunta tiene un identificador, un mensaje y una
% lista de respuestas posibles.

pregunta(genero,
    'Que genero de pelicula prefieres?',
    [accion, ciencia_ficcion, terror, comedia, drama, animacion, romance]).

pregunta(duracion,
    'Que duracion prefieres?',
    [corta, media, larga]).

pregunta(epoca,
    'De que epoca prefieres la pelicula?',
    [clasico, moderno, reciente, indiferente]).

pregunta(tono,
    'Que ambiente buscas?',
    [ligero, familiar, oscuro, emotivo, intenso]).

pregunta(animacion,
    'Te gustan las peliculas animadas stopmotion?',
    [si, no]).

pregunta(saga,
    'Te gustan las peliculas que pertenecen a una saga?',
    [si, no]).

pregunta(idioma,
    'Que idioma prefieres?',
    [espanol, ingles, indiferente]).

pregunta(ritmo,
    'Que ritmo prefieres?',
    [rapido, tranquilo, confuso, intenso]).


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
    [animacion, media, reciente, emotivo, si, no, ingles, tranquilo],
    'Memorias de un caracol',
    'Te gusta el stop-motion y buscas una historia reciente, emotiva y tranquila. Esta pelicula ofrece un relato profundo y conmovedor.'
).

recomendar(
    [romance, media, clasico, ligero, _, no, ingles, rapido],
    '10 cosas que odio de ti',
    'Buscas un romance clasico y ligero. Esta pelicula combina comedia juvenil, sarcasmo y una historia de amor muy entretenida.'
).

recomendar(
    [animacion, larga, clasico, emotivo, no, no, _, tranquilo],
    'El castillo vagabundo',
    'Buscas animacion clasica y emotiva con un ritmo tranquilo. Esta pelicula ofrece un mundo magico y una historia llena de fantasia.'
).

recomendar(
    [ciencia_ficcion, larga, reciente, emotivo, no, no, ingles, confuso],
    'Everything Everywhere All at Once',
    'Buscas ciencia ficcion reciente con una trama compleja y emotiva. Esta pelicula mezcla accion frenetica, multiversos y una historia familiar conmovedora.'
).

recomendar(
    [ciencia_ficcion, larga, moderno, emotivo, no, no, ingles, confuso],
    'Interestelar',
    'Buscas ciencia ficcion, una historia larga y emotiva. Esta pelicula combina exploracion espacial y drama.'
).

recomendar(
    [terror, media, moderno, oscuro, _, _, ingles, intenso],
    'Hereditary',
    'Elegiste terror y un ambiente oscuro. Esta pelicula destaca por su atmosfera inquietante.'
).

recomendar(
    [terror, media, _, oscuro, no, no, ingles, tranquilo],
    'The Whitch',
    'Un clasico del cine de terror, con una atmosfera perturbadora y un ritmo tranquilo que te mantendra en suspenso.'
).

recomendar(
    [ciencia_ficcion, larga, moderno, intenso, _, _, ingles, confuso],
    'Origen',
    'Buscas ciencia ficcion intensa y con una historia larga. Esta pelicula combina accion y un argumento complejo.'
).

recomendar(
    [accion, media, moderno, intenso, _, si, _, rapido],
    'Avengers: Endgame',
    'Buscas accion intensa y de saga. Esta pelicula ofrece un ritmo rapido y emocion constante.'
).

recomendar(
    [comedia, media, moderno, ligero, no, si, ingles, rapido],
    'Deadpool',
    'Buscas una comedia ligera y reciente. Esta pelicula combina humor oscuro y accion.'
).

recomendar(
    [romance, larga, moderno, emotivo, _, _, _, tranquilo],
    'La La Land',
    'Buscas romance con una historia larga y emocional. Esta pelicula combina musica y drama con dos personajes con los que puedes identificarte.'
).

recomendar(
    [drama, media, moderno, emotivo, no, no, _, tranquilo],
    'Cadena de favores',
    'Buscas un drama moderno y emotivo. Esta pelicula cuenta una historia conmovedora sobre como una buena accion puede cambiar muchas vidas.'
).

recomendar(
    [animacion, media, clasico, oscuro, si, _, _, _],
    'El extraño mundo de Jack',
    'te gusta el stopmotion y esta pelicula combina animacion con un ambiente oscuro y una historia emotiva.'
).

recomendar(
    [animacion, media, moderno, familiar, no, no, espanol, _],
    'Klaus',
    'Te gusta la animacion y un ambiente familiar, esta historia nos habla del verdadero significado de la navidad y la importancia de la amistad y la generosidad'
).

recomendar(
    [terror, larga, moderno, intenso, _, _, ingles, intenso],
    'El conjuro 3',
    'Buscas terror intenso, con una historia larga y actual, en ingles, y esta pelicula ofrece una experiencia unica en su clase'
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
    [animacion, _, _, _, no, no, espanol, _],
    'Coco',
    'Te gusta la animacion y prefieres el español. Esta pelicula combina musica, familia y emocion.'
).

recomendar(
    [animacion, _, _, _, no, si, _, _],
    'Spider-Man: Un nuevo universo',
    'Te gustan las peliculas animadas. Esta pelicula destaca por su estilo visual y accion.'
).

recomendar(
    [drama, _, clasico, _, _, _, _, _],
    'El padrino',
    'Prefieres los dramas clasicos. Esta pelicula es una historia de crimen y familia.'
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

recomendar(
    [romance, _, _, _, _, _, _, _],
    'Titanic',
    'Te interesa el romance. Esta pelicula ofrece una historia emotiva centrada en el amor.'
).

recomendar(
    [ciencia_ficcion, _, _, _, _, _, _, _],
    'Matrix',
    'Te interesa la ciencia ficcion. Esta pelicula combina accion con ideas filosoficas.'
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
