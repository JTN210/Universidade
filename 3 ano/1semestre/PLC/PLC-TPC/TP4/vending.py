import json, os, sys, re, datetime
from typing import List, Dict

"""
Comandos suportados:
    LISTAR
    MOEDA <lista de moedas separadas por vírgulas>  ex: MOEDA 1e, 20c, 5c
    SELECIONAR <cod>  ex: SELECIONAR A23
    ADICIONAR <cod> "<nome com espaços>" <quant> <preco>
    SAIR
"""

MOEDAS = [200, 100, 50, 20, 10, 5, 2, 1]  # em cêntimos
PADRÃO_MOEDA = re.compile(r'\s*(\d+)\s*([ec])\s*$', re.IGNORECASE)

def cents_fmt(v: int) -> str:
    euros, cents = divmod(abs(v), 100)
    sign = '-' if v < 0 else ''
    if euros and cents:
        return f"{sign}{euros}e{cents:02d}c"
    if euros:
        return f"{sign}{euros}e"
    return f"{sign}{cents}c"

def load_stock(path: str) -> List[Dict]:
    if not os.path.exists(path):
        return []
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)
    # normalizar
    for item in data:
        item["cod"] = str(item["cod"]).upper()
        item["nome"] = str(item["nome"])
        item["quant"] = int(item["quant"])
        item["preco"] = float(item["preco"])
    return data

def save_stock(path: str, stock: List[Dict]) -> None:
    with open(path, "w", encoding="utf-8") as f:
        json.dump(stock, f, ensure_ascii=False, indent=2)

def listar(stock: List[Dict]) -> None:
    print("maquina:")
    print("cod  | nome                | quantidade | preço")
    print("-" * 54)
    for it in stock:
        preco = f"{it['preco']:.2f}"
        print(f"{it['cod']:<4} | {it['nome']:<19} | {it['quant']:>10} | {preco:>5}")
    print()

def parse_coin(token: str) -> int:
    m =  PADRÃO_MOEDA.match(token)
    if not m:
        raise ValueError(f"Moeda inválida: {token!r}")
    val = int(m.group(1))
    unit = m.group(2).lower()
    return val * 100 if unit == 'e' else val

def moedas_to_text(cents: int) -> str:
    parts = []
    for c in MOEDAS:
        qtd, cents = divmod(cents, c)
        if qtd:
            parts.append(f"{qtd}x {c//100}e" if c >= 100 else f"{qtd}x {c}c")
    return ", ".join(parts) if parts else "0c"

def dar_troco(cents: int) -> Dict[int, int]:
    troco = {}
    for c in MOEDAS:
        qtd, cents = divmod(cents, c)
        if qtd:
            troco[c] = qtd
    return troco

def procurar(stock: List[Dict], cod: str):
    for it in stock:
        if it["cod"] == cod.upper():
            return it
    return None

def selecionar(stock: List[Dict], cod: str, saldo: int) -> int:
    it = procurar(stock, cod)
    if it is None:
        print("maquina: Produto inexistente.")
        return saldo
    preco_cents = int(round(it["preco"] * 100))
    if it["quant"] <= 0:
        print("maquina: Sem stock para esse produto.")
        return saldo
    if saldo < preco_cents:
        falta = preco_cents - saldo
        print(f"maquina: Saldo insuficiente para satisfazer o seu pedido")
        print(f"maquina: Saldo = {cents_fmt(saldo)}; Pedido = {cents_fmt(preco_cents)}")
        return saldo
    # vender
    it["quant"] -= 1
    saldo -= preco_cents
    print(f'maquina: Pode retirar o produto dispensado "{it["nome"]}"')
    print(f"maquina: Saldo = {cents_fmt(saldo)}")
    return saldo

def adicionar(stock: List[Dict], cod: str, nome: str, quant: int, preco: float):
    it = procurar(stock, cod)
    if it:
        it["quant"] += quant
        it["preco"] = float(preco)
    else:
        stock.append({"cod": cod.upper(), "nome": nome, "quant": int(quant), "preco": float(preco)})
    print("maquina: Stock atualizado.")

def main():
    path = os.environ.get("STOCK_FILE", "stock.json")
    stock = load_stock(path)
    dt = datetime.datetime.now().date().isoformat()
    print(f"maquina: {dt}, Stock carregado, Estado atualizado.")
    print("maquina: Bom dia. Estou disponível para atender o seu pedido.")

    saldo = 0  # em cêntimos

    while True:
        try:
            line = input(">> ").strip()
        except EOFError:
            line = "SAIR"
            print("SAIR")

        if not line:
            continue

        cmd, *rest = line.split(" ", 1)
        cmd = cmd.upper()

        if cmd == "LISTAR":
            listar(stock)

        elif cmd == "MOEDA":
            if not rest:
                print("maquina: Indique moedas: ex. MOEDA 1e, 20c, 5c")
                continue
            # separar por vírgulas ou espaços
            tokens = [t.strip() for part in rest[0].split(",") for t in part.strip().split() if t.strip()]
            try:
                total = sum(parse_coin(t) for t in tokens)
            except ValueError as e:
                print("maquina:", e)
                continue
            saldo += total
            print(f"maquina: Saldo = {cents_fmt(saldo)}")

        elif cmd == "SELECIONAR":
            if not rest:
                print("maquina: Indique o código do produto (ex.: SELECIONAR A23)")
                continue
            cod = rest[0].strip()
            saldo = selecionar(stock, cod, saldo)

        elif cmd == "ADICIONAR":  # extra
            if not rest:
                print('maquina: Uso: ADICIONAR <cod> "<nome>" <quant> <preco>')
                continue
            # usar regex para apanhar o nome entre aspas
            m = re.match(r'\s*(\S+)\s+"([^"]+)"\s+(\d+)\s+([0-9]+(?:\.[0-9]+)?)\s*$', rest[0])
            if not m:
                print('maquina: Formato inválido. Ex.: ADICIONAR C99 "bolacha choco" 6 1.10')
                continue
            cod, nome, quant, preco = m.group(1), m.group(2), int(m.group(3)), float(m.group(4))
            adicionar(stock, cod, nome, quant, preco)

        elif cmd == "SAIR":
            troco = dar_troco(saldo)
            if troco:
                # construir frase de troco
                parts = []
                for c, qtd in troco.items():
                    parts.append(f"{qtd}x {c//100}e" if c >= 100 else f"{qtd}x {c}c")
                print("maquina: Pode retirar o troco:", ", ".join(parts) + ".")
            else:
                print("maquina: Sem troco.")
            print("maquina: Até à próxima")
            save_stock(path, stock)
            break

        else:
            print("maquina: Comando inválido. Comandos: LISTAR | MOEDA | SELECIONAR | ADICIONAR | SAIR")

if __name__ == "__main__":
    main()
