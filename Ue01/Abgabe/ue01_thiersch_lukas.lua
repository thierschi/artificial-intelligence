-- Abgabe von Lukas Thiersch, bt708626, 1607110

operations = "2p3p3m6p2" --Eingabestring
            --2+3+3-6+2 = 4
            --ALWAYS number followed by operation followed by number ...

local function parseSymbol(input) --Funktion erwartet als Eingabe einen char. Dieser wird dann ausgewertet. Abhängig von der Eingabe ist ein anderer Rückgabetyp
    if (input == "p")
    then --Bei einem der Operatoren wird die entsprechende Funktion zurück gegeben.
        return function(a, b) return a + b end
    elseif (input == "m")
    then
        return function(a, b) return a - b end
    elseif (input == "n")
    then
        return function(a, b) return a * b end
    elseif (input == "d")
    then
        return function(a, b) return a / b end
    else
        return tonumber(input)
    end
end

local operation_t = {} --leere Table in der die Operationen und Zahlen gespeichert werden

local function main ()
    for it = 1, #operations do --Laufe mit it von 1 bis Länge des String operations. Der Standard Operator bei for-Schleifen ist it++. Deshalb kann der Operator, welcher nach jedem Durchlauf der Schleife aufgerufen wird, weggelassen werden
        operation_t[it] = parseSymbol(operations:sub(it,it)) --Das Symbol an der jeweiligen Stelle wird mit parseSymbol in Zahl bzw. Operator umgewandelt und in operation_t gespeichert
    end
    current = operation_t[1]    --current enthält das Zwischenergebnis
    size = 0
    for it = 1, #operation_t do --laufe durch Array operation_t
        if (type(operation_t[it]) ~= "number")
        then
            current = operation_t[it](current,operation_t[it+1]) --Aufruf der Funktion
            print(current) --Zwischenergebnis ausgeben
            it = it + 1
        end
    end
    print(current) --Endergebnis ausgeben
end
    
main()
