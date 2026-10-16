programa {
  funcao inicio() {
    const inteiro CAIXAS_POR_PALETES = 40
    inteiro quantidaDedeCaixas
    inteiro paletesCompletos
    inteiro caixasSobra
    real pesoCaixa
    real pesoTotal
    real temperatura

    escreva("Digite a quantidade de caixas produzidas: ")
    leia(quantidaDedeCaixas)
    escreva("Digite o peso de cada caixa: ")
    leia(pesoCaixa)
    escreva("Informe a temperatura da camara fria (°C): ")
    leia(temperatura)

    pesoTotal = quantidaDedeCaixas * pesoCaixa
    paletesCompletos = quantidaDedeCaixas/CAIXAS_POR_PALETES
    caixasSobra = quantidaDedeCaixas%CAIXAS_POR_PALETES

    se(temperatura <= -18 e paletesCompletos >= 1)
    {
      escreva("Carregamento liberado!\n")
    } senao {
      escreva("carregamento bloqueado!\n")
    } se (temperatura > -18){
      escreva("Motivo: camara fria acima de -18 °C. \n")
    } se( paletesCompletos < 1)
    {
      escreva("Motivo: nenhum palete completo. \n")
      
    }escreva("\n")
    escreva("----- DADOS -----\n")
    escreva("\n")
    escreva("O peso total é: ", pesoTotal, " kg\n")
    escreva("Paletes completos: ", paletesCompletos, "\n")
    escreva("Caixas que sobraram: ", caixasSobra, "\n")
  }
}
