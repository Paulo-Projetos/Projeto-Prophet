*** Settings ***
Library    SeleniumLibrary
Library    Collections             
Test Teardown    Close Browser       

*** Variables ***
${URL}        https://www.prophet.build/dashboard
${PROFILE}    C:/Projeto Prophet/chrome-profile-prophet

*** Test Cases ***
Fluxo de acesso e cadastro de cliente
    Dado que acesso o Dashboard Prophet
    E clico em Clientes
    
    Entao sou direcionado para a pagina de produtos
    Quando clico no produto    Picture of Blue Jeans    1,00
    Então sou direcionado para a pagina do produto
    Quando clico em adicionar no carrinho
    Entao visualizo o numero de itens no carrinho    1
    Quando clico no icone do carrinho
    Entao sou direcionado para a pagina do carrinho
    E confirmo se a descrição do produto no carrinho esta correta
    Quando clico Remover Item
    E clico em Atualizar Carrinho de Compras
    Entao sou direcionado para a pagina Carrinho de Compras

*** Keywords ***
Dado que acesso o Dashboard Prophet
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --user-data-dir\=${PROFILE}
    Call Method    ${options}    add_argument    --start-maximized
    Create WebDriver    Chrome    options=${options}
    Go To    ${URL}
    Sleep    15s

E clico em Clientes
    Wait Until Element Is Visible    css=button[aria-label="Clientes"]    30s
    Click Element    css=button[aria-label="Clientes"]






Entao sou direcionado para a pagina de produtos
    Element Text Should Be    css=h1    Apparel & Shoes
Quando clico no produto
    [Arguments]    ${Produto}    ${Price}
    Wait Until Element Is Visible    css=img[alt="${Produto}"]    ${timeout}
    Click Element    css=img[alt="${Produto}"]
Então sou direcionado para a pagina do produto
    Element Attribute Value Should Be    id=main-product-img-36    alt    Picture of Blue Jeans
    Element Text Should Be    css=span[itemprop="price"]    1.00
Quando clico em adicionar no carrinho
    Click Button    id=add-to-cart-button-36
Entao visualizo o numero de itens no carrinho
    [Arguments]    ${Items}
    Set Test Variable    ${Cart_items}    ${Items}
    Wait Until Element Contains    css=span.cart-qty    ${Cart_items}    ${timeout}
Quando clico no icone do carrinho
    Click Element    css=span.cart-label
Entao sou direcionado para a pagina do carrinho
    Wait Until Element Is Visible    css=h1    ${timeout}
    Element Text Should Be    css=h1    Shopping cart
E confirmo se a descrição do produto no carrinho esta correta
    Wait Until Element Is Visible    css=a.product-name    ${timeout}
    Element Text Should Be    css=a.product-name    Blue Jeans
    Element Text Should Be    css=span.product-unit-price    1.00
Quando clico Remover Item
    Click Element    name=removefromcart
E clico em Atualizar Carrinho de Compras
    Click Button    name=updatecart
Entao sou direcionado para a pagina Carrinho de Compras
    Wait Until Element Is Visible    css=h1    ${timeout}
    Element Text Should Be    css=h1    Shopping cart



