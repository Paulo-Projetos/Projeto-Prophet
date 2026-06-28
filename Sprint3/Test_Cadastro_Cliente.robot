*** Settings ***
Library    SeleniumLibrary
Test Teardown    Close Browser

*** Variables ***
${URL}        https://www.prophet.build/dashboard
${EMAIL}      pcfmuniz@yahoo.com.br

*** Test Cases ***
Fluxo de acesso e cadastro de cliente
    Abrir Prophet
    Fazer Login Via Magic Link Se Necessario
    E clico em Clientes
    Quando clico no cliente Squad 145
    Quando clico em Nova Tarefa
    E envio pergunta sobre o cliente Squad 145

    E clico em Clientes
    Quando clico no cliente Squad 145
    Quando clico na aba Conhecimento
    Quando abro a pasta Squad 145 Marketing
    Quando abro o arquivo Teste.txt

*** Keywords ***
Abrir Prophet
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
Fazer Login Via Magic Link Se Necessario
    Wait Until Element Is Visible    xpath=//input[@placeholder="Endereço de email"]    30s
    Input Text    xpath=//input[@placeholder="Endereço de email"]    ${EMAIL}
    Click Element    xpath=//button[@role="checkbox"]
    Wait Until Element Is Enabled    xpath=//button[contains(.,"Enviar magic link")]    10s
    Click Button    xpath=//button[contains(.,"Enviar magic link")]
    Log To Console    Abra seu e-mail, clique no link mágico da Prophet e aguarde o Dashboard abrir. Você tem 80 segundos.
    Sleep    80s
    ${abas}=    Get Window Handles
    FOR    ${aba}    IN    @{abas}
        Switch Window    ${aba}
        ${url_atual}=    Get Location
        Log To Console    ABA ENCONTRADA: ${url_atual}
    END
E clico em Clientes
    Wait Until Element Is Visible    css=button[aria-label="Clientes"]    10s
    Click Element    css=button[aria-label="Clientes"]
    Sleep    5s
    ${url_atual}=    Get Location
    Log To Console    URL APOS CLICAR EM CLIENTES: ${url_atual}
    Sleep    10s
Quando clico no cliente Squad 145
    Wait Until Location Contains    /clients    10s
    Wait Until Page Contains    Squad 145 Marketing    10s
    Click Element    xpath=(//*[normalize-space(.)="Squad 145 Marketing"])[1]
    Sleep    5s
    ${url}=    Get Location
    Log To Console    URL APOS CLICAR NO CLIENTE: ${url}
Quando clico em Nova Tarefa
    Wait Until Location Contains    /clients/    10s
    Sleep    3s
    ${clicou}=    Execute Javascript
    ...    const elementos = [...document.querySelectorAll('button, a, [role="button"]')];
    ...    const botao = elementos.find(e => e.innerText && (e.innerText.includes('Nova Tarefa') || e.innerText.includes('New Task')));
    ...    if (botao) { botao.click(); return true; }
    ...    return false;
    Should Be True    ${clicou}
    Sleep    3s
E envio pergunta sobre o cliente Squad 145
    Wait Until Element Is Visible    xpath=//textarea[contains(@placeholder,"Descreva")]    20s
    Input Text    xpath=//textarea[contains(@placeholder,"Descreva")]    Mostrar informações sobre o cliente Squad 145 Marketing
    Press Keys    xpath=//textarea[contains(@placeholder,"Descreva")]    ENTER
    Sleep    40s
Quando clico na aba Conhecimento
    Wait Until Element Is Visible    css=button[role="tab"][id$="trigger-knowledge"]    20s
    Click Element    css=button[role="tab"][id$="trigger-knowledge"]
    Sleep    3s
Quando abro a pasta Squad 145 Marketing
    Wait Until Element Is Visible
    ...    xpath=//h3[normalize-space(.)="Squad 145 Marketing"]
    ...    20s
    Click Element
    ...    xpath=//h3[normalize-space(.)="Squad 145 Marketing"]
    Sleep    3s
    ${url}=    Get Location
    Log To Console    URL APÓS ABRIR PASTA: ${url}
Quando abro o arquivo Teste.txt
    Wait Until Element Is Visible    xpath=//h3[normalize-space(.)="Teste.txt"]    20s
    Click Element    xpath=//h3[normalize-space(.)="Teste.txt"]
    Sleep    5s
    ${url}=    Get Location
    Log To Console    URL APÓS ABRIR ARQUIVO: ${url}
    Sleep    5s