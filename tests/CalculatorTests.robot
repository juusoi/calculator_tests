*** Settings ***
Documentation     Tests to verify simple calculations with Web 2.0 Calculator
Test Setup        Open calulator and clear
Test Teardown     Close all browsers
Default Tags      regression
Library           Selenium2Library
Library           calclib.py

*** Variables ***
${URL}            https://web2.0calc.com/
${BROWSER}        ff
&{buttons}        0=Btn0    1=Btn1    2=Btn2    3=Btn3    4=Btn4    5=Btn5    6=Btn6
...               7=Btn7    8=Btn8    9=Btn9    plus=BtnPlus    minus=BtnMinus    times=BtnMult    divided_by=BtnDiv
...               clear=BtnClear    calculate=BtnCalc

*** Test Cases ***
Addition
    Calculate 1 plus 5
    and Verify that the answer is 6

Subtraction
    Calculate 20 minus 7
    and Verify that the answer is 13

Multiplication
    Calculate 3 times 5
    and Verify that the answer is 15

Division
    Calculate 14 divided_by 2
    and Verify that the answer is 7

*** Keywords ***
Open calulator and clear
    Open Browser    ${URL}    ${BROWSER}
    Page Should Contain Element    calccontainer
    Press clear

Press ${button}
    Click Button    &{buttons}[${button}]

Calculate ${value1} ${operation} ${value2}
    [Documentation]    ${value1}, ${value2} are integers
    ...
    ...    ${operation} can be plus, minus, times, divide_by, clear or calculate
    ...
    ...    Values are converted to single digits
    Input digit    ${value1}
    Press ${operation}
    Input digit    ${value2}
    Press calculate

Verify that the answer is ${answer}
    ${value}    Get Element Attribute    input    value
    Should Be Equal As Integers    ${value}    ${answer}

Input digit
    [Arguments]    ${integer}
    @{digits}    Value to digits    ${integer}
    : FOR    ${digit}    IN    @{digits}
    \    Press ${digit}
