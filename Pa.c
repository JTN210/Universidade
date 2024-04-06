#include <stdio.h>
#include <locale.h>
#include <wchar.h>
#include <strings.h>

int nmber_of_cards(wchar_t *mao)
{
    int i;
    for (i = 0; mao[i] != '\0'; i++);
    return (i);
}

int pertence_ao_array(wchar_t carta, int posicao_valor_carta, wchar_t cartas[14][4])
{
    for (int i = 0; i < 4; i++)
    {
        if (carta == cartas[posicao_valor_carta][i])
            return (1);
    }
    return (0);
}

int valor_carta(wchar_t carta, wchar_t cartas[14][4])
{
    for (int i = 0; i < 14; i++)
    {
        if (pertence_ao_array(carta, i, cartas))
        {
            return (i + 1);
        }
    }
    return (-1);
}
wchar_t carta_mais_alta(wchar_t mao, int hand_len, wchar_t cartas[14][4])
{
    for (int i = 13; i >= 0; i--)
    {
        for (int j = 3; j >= 0; j--)
        {
            for (int k = 0; k < hand_len; k++)
            {
                if (mao[k] == cartas[i][j])
                    return (cartas[i][j]);
            }
        }
    }
    return (0);
}

int is_conj(intvalor_das_cartas_na_mao)
{
    int nmber_not_zeros = 0;
    int conj_len = 0;
    for (int i = 0; i < 14; i++)
    {
        if (valor_das_cartas_na_mao[i] != 0)
        {
            nmber_not_zeros++;
            conj_len = valor_das_cartas_na_mao[i];
        }
        if (nmber_not_zeros == 2)
            return (0);
    }
    return (conj_len);
}

void dseq_ou_seq(wchar_t valor_das_cartas_na_mao, int seq_flag, int seq_len, wchar_tmao, int hand_len, wchar_t cartas[14][4])
{
    int value = 0;
    int i = 0;
    for (; i < 14; i++)
    {
        if (valor_das_cartas_na_mao[i] != 0)
        {
            value = valor_das_cartas_na_mao[i];
            break;
        }
    }
    for (; valor_das_cartas_na_mao[i] == value && i < 14; i++, seq_len++);
    seq_flag = 1;
    if (seq_len < 3)
        wprintf(L"Nada!\n");
    else
    {
        for (; i < 14; i++)
        {
            if (valor_das_cartas_na_mao[i] != 0)
                seq_flag = 0;
        }
        if (seq_flag == 1)
        {
            if (value == 1)
                wprintf(L"sequência com %d cartas onde a carta mais alta é %C\n", seq_len, carta_mais_alta(mao, hand_len, cartas));
            else if (value == 2)
                wprintf(L"dupla sequência com %d cartas onde a carta mais alta é %C\n", seq_len, carta_mais_alta(mao, hand_len, cartas));
            else
                wprintf(L"Nada!");
        }
    }
}
int main()
{
    setlocale(LC_CTYPE, "C.UTF-8");
    int n;
    wchar_t cartas[14][4] = {{0x1F0A1, 0x1F0B1, 0x1F0C1, 0x1F0D1}, {0x1F0A2, 0x1F0B2, 0x1F0C2, 0x1F0D2}, {0x1F0A3, 0x1F0B3, 0x1F0C3, 0x1F0D3}, {0x1F0A4, 0x1F0B4, 0x1F0C4, 0x1F0D4}, {0x1F0A5, 0x1F0B5, 0x1F0C5, 0x1F0D5}, {0x1F0A6, 0x1F0B6, 0x1F0C6, 0x1F0D6}, {0x1F0A7, 0x1F0B7, 0x1F0C7, 0x1F0D7}, {0x1F0A8, 0x1F0B8, 0x1F0C8, 0x1F0D8}, {0x1F0A9, 0x1F0B9, 0x1F0C9, 0x1F0D9}, {0x1F0AA, 0x1F0BA, 0x1F0CA, 0x1F0DA}, {0x1F0AB, 0x1F0BB, 0x1F0CB, 0x1F0DB}, {0x1F0AC, 0x1F0BC, 0x1F0CC, 0x1F0DC}, {0x1F0AD, 0x1F0BD, 0x1F0CD, 0x1F0DD}, {0x1F0AE, 0x1F0BE, 0x1F0CE, 0x1F0DE}};
    if (scanf("%d", &n) == 1)
    {
        wchar_t mao[30];
        for (int contagem = 0; contagem < n; contagem++)
        {
            if (scanf("%ls", mao) == 1)
            {
                int seq_flag = 0;
                int conj_len = 0;
                int seq_len = 0;
                int hand_len = nmber_of_cards(mao); // tudo ok
                int valor_das_cartas_na_mao[14] = {0};
                for (int i = 0; mao[i] != '\0'; i++) // esta a colocar quantas cartas de cada valor tem
                    (valor_das_cartas_na_mao[valor_carta(mao[i], cartas) - 1])++; // esta a colocar corretamente
                conj_len = is_conj(valor_das_cartas_na_mao);
                if (conj_len)
                    wprintf(L"conjunto com %d cartas onde a carta mais alta é %C\n", conj_len, carta_mais_alta(mao, hand_len, cartas));
                else
                    dseq_ou_seq(valor_das_cartas_na_mao, seq_flag, seq_len, mao, hand_len, cartas);
                // wprintf(L"%S\n", mao); esta a imprimir corretamente
            }
        }
    }

}
