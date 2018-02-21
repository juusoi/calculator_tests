*** Settings ***
Test Setup        Open calulator and clear
Test Teardown     Close all browsers
Library           Selenium2Library

*** Variables ***
${URL}            https://web2.0calc.com/
${BROWSER}        ff
&{buttons}        1=Btn1    2=Btn2    3=Btn3    4=Btn4    5=Btn5    6=Btn6    7=Btn7
...               8=Btn8    9=Btn9    plus=BtnPlus    minus=BtnMinus    times=BtnMult    divided_by=BtnDiv    clear=BtnClear
...               calculate=BtnCalc

*** Test Cases ***
Addition
    [Tags]    regression
    Calculate 1 plus 5
    and Verify that answer is 6

Subtraction
    Calculate 20 minus 7
    and Verify that answer is 13

Multiplication
    Calculate 3 times 5
    and Verify that answer is 15

Division
    Calculate 14 divided_by 2
    and Verify that answer is 7

*** Keywords ***
Open calulator and clear
    Open Browser    ${URL}    ${BROWSER}
    Page Should Contain Element    calccontainer
    Press clear

Press ${button}
    Click Button    &{buttons}[${button}]

Calculate ${value1} ${operation} ${value2}
    Press ${value1}
    Press ${operation}
    Press ${value2}
    Press calculate

Verify that answer is ${answer}
    ${value}    Get Element Attribute    input    value
    Should Be Equal As Integers    ${value}    ${answer}
