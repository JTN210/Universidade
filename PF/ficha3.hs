import Data.Char
import Data.List

-- fazer o 4 da ficha 1 para saber fazer este
--ficha 1 4
data Hora = H Int Int deriving (Show,Eq)

--a
horavalida :: Hora -> Bool
horavalida (H x y) | (x >= 0 && x <= 23) && (y >= 0 && y <= 59) = True
                   | otherwise = False

compararHoras :: Hora -> Hora -> Bool
compararHoras (H x y) (H a b) | x < a = True
                              | x == a && y < b = True 
                              | otherwise = False 

horasminutos :: Hora -> Int
horas (H x y) = x*60 + y


minutosHoras :: Hora -> Int 
minutosHoras (H x y) = x + y / 60 


data Hora = H Int Int
deriving Show
type Etapa = (Hora,Hora)
type Viagem = [Etapa]

etapabemconstruida :: Etapa -> Bool
etapabemconstruida (partida,chegada) | horavalida partida && horavalida chegada && compararHoras partida chegada = True 
                         | otherwise = False


viagembemconstruida :: Viagem -> Bool
viagembemconstruida [] = True
viagembemconstruida ((partida,chegada):(p2,c2):t) | (compararHoras partida chegada) && compararHoras chegada p2 = viagembemconstruida (p2,c2) : t
                                          | otherwise = False

calcularPC :: Viagem -> Etapa
calcularPC [] = []
calcularPC [(p1,ch1)] = (p1,ch1)
calcularPC ((p1,ch1):t) = (p1, snd last t)  

tempEF :: Viagem -> Int
tempEF [] = 0
tempEF (h:t) = horasminutos (aux h ) + tempEF t   

aux :: Etapa -> Hora
aux [(H x y), (H a b)] = (H a-x b-y)

tempEspera :: Viagem -> Int
tempEspera [] = 0
tempEspera [_] = 0
tempEspera [(p1,c1):(p2,c2):t] | (horasminutos p2 - horasminutos c1) > 0 = (horasminutos p2 - horasminutos c1)+ tempEspera (p2,c2):t
                               | otherwise = tempEspera (p2,c2):t

tempTotal :: Viagem -> Int
tempTotal [] = 0
tempTotal [(p1,c1)] = horasminutos c1 - horasminutos p1 
tempTotal [(p1,c1):t] = horasminutos (snd (last t)) - horasminutos p1 
--3

data Contacto = Casa Integer
              | Trab Integer
              | Tlm Integer
              | Email String
         deriving Show
type Nome = String
type Agenda = [(Nome, [Contacto])]

c1,c2,c3 :: Contacto 
c1 = casa 234
c2 = Trab 456
c3 = Email "abc"

c4,c5  :: Agenda
c4 = [("jose",[]) ]
c5 = [("joao", [Casa 123, Email "joao"])]

tlm :: Agenda -> [Integer]
tlm [] = []
tlm ((nome,cont):t) | auxTlm ++ tlm t
                    | otherwise = tlm t

auxTlm :: [Contacto] -> [Integer]
auxTlm [] = []
auxTlm (h:t) | h == Tlm x = x  
             | otherwise = auxTlm t


acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail nome email agenda = Agenda ++ [(nome,[Email email])] 

verEmails :: Nome -> Agenda -> Maybe [String]
verEmails


consTelefs :: [Contacto] -> [Integer]
consTelefs [] = []
consTelefs (h:t) | h == Casa x = x : consTelefs t 
                 | h == Tlm x = x : consTelefs t 
                 | h == Trab x = x : consTelefs t 
                 | otherwise = consTelefs t 

casa :: Nome -> Agenda -> Maybe Integer
casa x [] = Nothing
casa n ((i,j):t) | n /= i = casa n t
                 | otherwise = Pcasa j
Pcasa :: [Contacto] -> Maybe Integer
Pcasa [] = Nothing
Pcasa (Casa n : t) = just n
Pcasa (c:t) = Pcasa t 

 --4
type Dia = Int
type Mes = Int
type Ano = Int
type Nome = String
data Data = D Dia Mes Ano
deriving Show
type TabDN = [(Nome,Data)]

procura :: Nome -> TabDN -> Maybe Data
procura _ [] = Nothing
procura x ((y,ys):t) | x == y = just ys 
                     | otherwise = procura x t 
                    
idade :: Data -> Nome -> TabDN -> Maybe Int
idade (D d1 m1 a1) nome ((nom,(D d2 m2 a2):t)) | nome /= nom = idade (D d1 m1 a1) nome t
                                              | (a1 < a2) || (a1 == a2 && m1 < m2)  || (a1 == a2 && m1 == m2 && d1 < d2) = Nothing 
                                              | (m1 < m2 ) || (m1 == m2 && d1 > d2) = just (a1-a2-1)
                                              |otherwise = just (a1-a2)
anterior :: Data -> Data -> Bool
anterior (D dia1 mes1 ano1) (D dia2 mes2 ano2) | ano1 < ano2 = True 
                                            | ano1 == ano2 && mes1 < mes2 = True
                                            | ano1 == ano2 && mes1 == mes2 && dia1 < dia2 = True
                                            | otherwise = False

 ordena :: TabDN -> TabDN 
 ordena [] = []
 ordena ((x,(D d1 m1 a1)):(y,D d2 m2 a2):t) | (a1 == a2 && m1 == m2 && d1 < d2 ) = (x,(D d1 m1 a1)) : ordena (y, (D d2 m2 a2)) t
                                            | (a1 == a2 && m1 < m2 ) = (x,(D d1 m1 a1)) : ordena (y,(D d2 m2 a2)) t
                                            | (a1 < a2) = (x,(D d1 m1 a1)) : ordena (y,(D d2 m2 a2)) t
                                            | otherwise = (y,(D d2 m2 a2)) : ordena (x,(D d1 m1 a1)) t 

-- 5

data Movimento = Credito Float | Debito Float
deriving Show
data Data = D Int Int Int
deriving Show
data Extracto = Ext Float [(Data, String, Movimento)]
deriving Show

extValor :: Extracto -> Float -> [Movimento]