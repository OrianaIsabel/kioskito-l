% Aquí va el código.
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).

atiende(lucas, martes, 10, 20).

atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).

atiende(juanFDS, jueves, 10, 20).
atiende(juanFDS, viernes, 12, 20).

atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).

atiende(martu, miercoles, 23, 24).

% Punto 1

atiende(vale, Dia, Inicio, Fin):-
    atiende(dodain, Dia, Inicio, Fin).

atiende(vale, Dia, Inicio, Fin):-
    atiende(juanC, Dia, Inicio, Fin).

% Punto 2

quienAtiende(Persona, Dia, Hora):- 
    atiende(Persona, Dia, Inicio, Fin),
    between(Inicio, Fin, Hora).

% Punto 3

foreverAlone(Persona, Dia, Hora):-
    quienAtiende(Persona, Dia, Hora),
    not((quienAtiende(Persona1, Dia, Hora), Persona1 \= Persona)).

% Punto 4

sinRepetidos([]).

sinRepetidos([Cabeza|Cola]):-
    not(member(Cabeza, Cola)),
    sinRepetidos(Cola).

incluido([Incluida], Lista):-
    member(Incluida, Lista).

incluido([Cabeza|Cola], Lista):-
    member(Cabeza, Lista);
    incluido(Cola, Lista). 

atiendenEnDia(Dia, [Persona]):-
    atiende(Persona, Dia,_,_).

atiendenEnDia(Dia, [Persona|Personas]):-
    sinRepetidos([Persona|Personas]),
    findall(Persona, atiende(Persona, Dia,_,_), QuienesAtienden),
    incluido([Persona|Personas], QuienesAtienden).

% Punto 5

vendio(dodain, fecha(10, 08), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
vendio(dodain, fecha(12, 08), [bebidas(alcohol, 8), bebidas(no_alcohol, 1), golosinas(10)]).

vendio(martu, fecha(12, 08), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).

vendio(lucas, fecha(11, 08), [golosinas(600)]).
vendio(lucas, fecha(18, 08), [bebidas(no_alcohol, 2), cigarrillos([derby])]).

ventaImportante(golosinas(Plata)):-
    Plata > 100.

ventaImportante(cigarrillos(Marcas)):-
    length(Marcas, Cantidad),
    Cantidad > 2.

ventaImportante(bebidas(alcohol,_)).

ventaImportante(bebidas(no_alcohol, Cantidad)):-
    Cantidad > 5.

diaImportante(Persona, fecha(Dia, Mes)):-
    vendio(Persona, fecha(Dia, Mes), [Primero|_]),
    ventaImportante(Primero).

suerte(Persona):-
    vendio(Persona,_,_),
    forall(vendio(Persona, fecha(Dia, Mes),_), diaImportante((Persona), fecha(Dia, Mes))).
    