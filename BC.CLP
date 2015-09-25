(deftemplate nodo-respuesta
(slot nombre)
(slot valor)
)
;------------------------------------------------------
(deftemplate nodo-decision
(slot nombre)
(slot pregunta)
(slot respuesta-si)
(slot respuesta-no)
)
;------------------------------------------------------
(defrule inicializacion
(inicio ?ruta)
(not(nodo-decision (nombre raiz)))
=>
(load-facts ?ruta)
(assert(nodo-actual raiz))
)
;------------------------------------------------------
(defrule pregunta-en-nodo-decision
(nodo-actual ?nombre)
(nodo-decision(nombre ?nombre)(pregunta ?pregunta))
(not(respuesta ?))
=>
(assert(pregunta ?pregunta));
)
;------------------------------------------------------
(defrule respuesta-incorrecta
?respuesta<-(respuesta ~si & ~no)
=>
(retract ?respuesta)
(printout t "Respuesta incorrecta" crlf)
)
;------------------------------------------------------
(defrule procesa-si-en-nodo-decision
?preg <- (pregunta ?)
?nodo<-(nodo-actual ?nombre)
(nodo-decision(nombre ?nombre)(respuesta-si ?si))
?respuesta<-(respuesta si)
=>
(retract ?nodo ?respuesta ?preg)
(assert(nodo-actual ?si))
)
;------------------------------------------------------
(defrule procesa-no-en-nodo-decision
?preg <- (pregunta ?)
?nodo<-(nodo-actual ?nombre)
(nodo-decision(nombre ?nombre)(respuesta-no ?no))
?respuesta<-(respuesta no)
=>
(retract ?nodo ?respuesta ?preg)
(assert(nodo-actual ?no))
)
;------------------------------------------------------
(defrule pregunta-en-nodo-respuesta
(nodo-actual ?nombre)
(nodo-respuesta(nombre ?nombre)(valor ?valor))
(not(respuesta ?))
=>
(assert(solucion ?valor))
;(printout t "Estoy en lo cierto? (si o no): " ?valor crlf)
;(assert(respuesta(read)))
)
;------------------------------------------------------
(defrule procesa-si-en-nodo-respuesta
?nodo<-(nodo-actual ?nombre)
(nodo-respuesta(nombre ?nombre))
?respuesta<-(respuesta si)
=>
(retract ?nodo ?respuesta)
(assert(pregunta-de-nuevo))
)
;------------------------------------------------------
(defrule procesa-no-en-nodo-respuesta
?nodo<-(nodo-actual ?nombre)
(nodo-respuesta(nombre ?nombre))
?respuesta<-(respuesta no)
=>
(retract ?nodo ?respuesta)
(assert(reemplaza-nodo-respuesta ?nombre))
)
;------------------------------------------------------
(defrule pregunta-de-nuevo
(pregunta-de-nuevo)
(not(respuesta ?))
=>
(printout t "¿Lo intentamos de nuevo? (si o no): ")
(assert(respuesta(read)))
)
;------------------------------------------------------
(defrule una-vez-mas
?fase<-(pregunta-de-nuevo)
?respuesta<-(respuesta si)
=>
(retract ?fase ?respuesta)
(assert(nodo-actual raiz))
)
;------------------------------------------------------
(defrule no-mas-por-favor
?fase<-(pregunta-de-nuevo)
?respuesta<-(respuesta no)
=>
(retract ?fase ?respuesta)
(save-facts "facts.dat")
)
;------------------------------------------------------
(defrule aprende
?h<-(reemplaza-nodo-respuesta ?nombre)
?dato<-(nodo-respuesta(nombre ?nombre)(valor ?valor))
=>
(retract ?h ?dato)
(printout t "¿Qué resultado es.? " crlf)
(bind ?rstdo (read))
(printout t "¿Qué pregunta se debe contestar afirmativamente? para distinguir " crlf)
(printout t " " ?rstdo " de " ?valor " .? " crlf)
(bind ?pregunta (readline))
(printout t "Ahora ya puedo distinguir " ?rstdo crlf)
(bind ?nodo1 (gensym*))
(bind ?nodo2 (gensym*))
(assert 
(nodo-respuesta (nombre ?nodo1) (valor ?rstdo))
(nodo-respuesta (nombre ?nodo2) (valor ?valor))
(nodo-decision (nombre ?nombre) (pregunta ?pregunta)
	         (respuesta-si ?nodo1) (respuesta-no ?nodo2)
)
(pregunta-de-nuevo)
)
)
