unit inkCLL;
{<*** Cyclic Linked Lists [ in0k © 13.01.2013 ]
    * библиокека для работы с "Циклическими Связными Списками"
    *}
{//..........................................................................///
///                              _____                                       ///
///                      Cyclic |   __|_ _ first -> -                        ///
///                      Linked |  |__| | |         -                        ///
///                      Lists  |_____|_|_|         -                        ///
///                              v 0.9     first <- =                        ///
///--------------------------------------------------------------------------//}
{краткое содержание повествования://------------------------------------//

  #1 объявление типов
  ===================



  #2 работа со списком
  ====================

    -- 2.00-FF рождение и смерть
    00    - создание/инициализация
    --
    FF    - оЧистка/уничтожение
    FFx0  - очистка с уничтожением pQueueNode (вообще, это тока для тестов)
    FFx1  - очистка с вызовом-по-указателю функции
    FFx2  - очистка с вызовом-по-указателю МЕТОДА класса

    -- 2.2 текущие/очевидные свойства списка
    10    - проверка на пустоту
    11    - количесво узлов

    -- 2.3 от кончика ушей до пят (операции над ВСЕМ списком)
    20    - обход списка (с первого по последний)
    20x1  - обход списка с вызовом-по-указателю функции
    20x2  - обход списка вызовом-по-указателю МЕТОДА класса
    69    - инвертирование списка

    -- 2.5 последний Герой (последний узел списка)
    05v1  - последний Узел
    05v2  - последний Узел и общее кол-во узлов

    -- 2.6 вырезать "МЕНЯ"
    C0v1  - вырезать УЗЕЛ (САМОГО СЕБЯ)
    C0v2  - вырезать УЗЕЛ (САМОГО СЕБЯ) и подтверждение и вырезании

    -- 2.7 Грива и Хвост (вставка/удаление из начала и конца очереди)
    C1    - вырезать УЗЕЛ из Начала списка
    06    - вставить УЗЕЛ в начало списка
    07    - вставить СПИСОК в начало списка
    --
    C2    - вырезать ВТОРОЙ элемент списка
    16    - вставить УЗЕЛ в список ВТОРЫМ элементом
    --
    CFv1  - вырезать УЗЕЛ из Конца списка
    CFv2  - вырезать УЗЕЛ из Конца списка
    08v1  - вставить УЗЕЛ в конец списка
    08v2  - вставить УЗЕЛ в конец списка и общее кол-во узлов
    09v1  - вставить СПИСОК в конец списка
    09v2  - вставить СПИСОК в конец списка и общее кол-во узлов

    -- 2.8 МАССИВ
    A1v1  - элемент с индексом
    A1v2  - элемент с индексом или ПОСЛЕДНИЙ
    A2    - индекс элемента (принадлежит ли элемент списку)
    --
    A3    - вставить элемент с индексом
    A4    - вставить СПИСОК с индексом
    --
    A5    - вырезать элемент с индексом
    A6    - вырезать СПИСОК с индексом

//---------------------------------------------------------------------------//}
interface
{%region /fold}//----------------------------------[ compiler directives ]
{}  {$ifdef fpc}                                             { это для LAZARUS }
{}     {$mode delphi}     // для пущей совместимости написанного кода         {}
{}     {$define _INLINE_}                                                     {}
{}  {$else}                                                   { это для DELPHI }
{}     {$IFDEF SUPPORTS_INLINE}                                               {}
{}       {$define _INLINE_}                                                   {}
{}     {$endif}                                                               {}
{}  {$endif}                                                                  {}
{}  {$ifOpt D+} // режим дебуга ВКЛЮЧЕН                      { "боевой" INLINE }
{}       {$undef _INLINE_} // дeбугить просче БЕЗ INLIN`а                     {}
{}  {$endif}                                                                  {}
{%endregion}//-------------------------------------------[ compiler directives ]
{$ifOpt D+}
{$define inkCLL_FncSrcMessage} //< сообщения о текущей процедуре, с ними проще ловить ошибки
{$endif}
{$ifOpt D+}
uses sysutils;                 //< попытка отлова ДИНАМИЧЕСКИХ ошибок
{$endif}
//****************************************************************************//
//                                                                            //
//                                                                   ЧАСТЬ #1 //
//                                                                            //
//****************************************************************************//
type

 {$define _INLINE_}


  // "допустимое" количество элементов в очереди
 tQueueIndexNode =longWord;        // {4-byte} индекс узла в очереди
 tQueueCountNodes=tQueueIndexNode; // {4-byte} количество узлов в очереди

const
 cQueueMaxCount=high(tQueueCountNodes);
 cQueueMaxIndex=cQueueMaxCount-1;

type

 pQueueNode=^rQueueNode;
 rQueueNode=record
    next:pointer;  //< ссылка-указатель на следующий элемент очереди
  end;

 tQueue=pQueueNode;

{"callBack" при УНИЧТОЖЕНИИ (см. @link(queue_CLEAR))
 !!! СТАТИЧЕСКАЯ функция !!!
 @param(NODE это ссылка-указатель на УЗЕЛ очереди [pQueueNode])                }
fInkSLL_doDispose=procedure(NODE:pointer);
{"callBack" при обходе очереди
 !!! метод ОБЪЕКТА-класса !!!
 @param(NODE это ссылка-указатель на УЗЕЛ очереди [pQueueNode])                }
aInkSLL_doDispose=procedure(NODE:pointer) of object;

{"callBack" обработать Узел при обходе очереди (см. @link(queue_ProcessDirect))
 !!! СТАТИЧЕСКАЯ функция !!!
 @param(Data АДРЕС-памяти, некая инфа используемая при обходе)
 @param(NODE это ссылка-указатель на УЗЕЛ очереди [pQueueNode])
 @param(continue @true -- продолжить дальнейшую работу, @false -- ПРЕКРАТИТЬ)  }
fInkSLL_doProcess=function(const Data:pointer; const NODE:pointer):boolean;
{"callBack" обработать Узел при обходе очереди (см. @link(queue_ProcessDirect))
 !!! метод ОБЪЕКТА-класса !!!
 @param(Data АДРЕС-памяти, некая инфа используемая при обходе)
 @param(NODE это ссылка-указатель на УЗЕЛ очереди [pQueueNode])
 @param(continue @true -- продолжить дальнейшую работу, @false -- ПРЕКРАТИТЬ)  }
aInkSLL_doProcess=function(const Data:pointer; const NODE:pointer):boolean;


//****************************************************************************//
//                                                                            //
//                                                                   ЧАСТЬ #2 //
//                                                                            //
//****************************************************************************//

//== 2.0-F рождение и смерть ==

procedure inkCLL_INIT(out CLL:pointer);                                         {$ifdef _INLINE_} inline; {$endif}

procedure inkCLL_clean_fast(var CLL:pointer);                                   {$ifdef _INLINE_} inline; {$endif}
procedure inkCLL_CLEAR_fast(var CLL:pointer; disposePRC:fInkSLL_doDispose);     {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkCLL_CLEAR_fast(var CLL:pointer; disposePRC:aInkSLL_doDispose);     {$ifdef _INLINE_} inline; {$endif} overload;

//== 2.2 текущие/очевидные свойства списка ==

function  inkCLL_isEmpty (const CLL:pointer):boolean;                           {$ifdef _INLINE_} inline; {$endif}
function  inkCLL_clcCount(const CLL:pointer):tQueueCountNodes;                  {$ifdef _INLINE_} inline; {$endif}

//== 2.3 от кончика ушей до пят (операции над ВСЕМ списком) ==

function  inkCLL_Enumerate(const CLL:pointer; const enumData:pointer; const enumFNC:fInkSLL_doProcess):pointer; {$ifdef _INLINE_} inline; {$endif} overload;
function  inkCLL_Enumerate(const CLL:pointer; const enumData:pointer; const enumFNC:aInkSLL_doProcess):pointer; {$ifdef _INLINE_} inline; {$endif} overload;
(*procedure inkSLL_Invert   (var   CLL:pointer);                                                                  {$ifdef _INLINE_} inline; {$endif}

//== 2.5 последний Герой (последний узел списка) ==

function  inkSLL_getLast(const CLL:pointer):pointer;                            {$ifdef _INLINE_} inline; {$endif} overload;
function  inkSLL_getLast(const CLL:pointer; out Count:tQueueCountNodes):pointer;{$ifdef _INLINE_} inline; {$endif} overload;

//== 2.6 вырезать "МЕНЯ" ==

procedure inkSLL_cutNode   (var CLL:pointer; const Node:pointer);               {$ifdef _INLINE_} inline; {$endif} overload;
function  inkSLL_cutNodeRes(var CLL:pointer; const Node:pointer):boolean;       {$ifdef _INLINE_} inline; {$endif} overload;

//== 2.7 Грива и Хвост (вставка/удаление из начала и конца СПИСКА) ==

//=== Грива ===

function  inkSLL_cutNodeFirst(var CLL:pointer):pointer;                         {$ifdef _INLINE_} inline; {$endif}
procedure inkSLL_insNodeFirst(var CLL:pointer; const Node:pointer);             {$ifdef _INLINE_} inline; {$endif}
procedure inkSLL_insListFirst(var CLL:pointer; const List:pointer);             {$ifdef _INLINE_} inline; {$endif}

*)
//=== ШЕЯ ===

function  inkCLL_cutNodeSecond(const CLL:pointer):pointer;                      {$ifdef _INLINE_} inline; {$endif}
//procedure inkCLL_insNodeSecond(var CLL:pointer; const Node:pointer);            {$ifdef _INLINE_} inline; {$endif}

(*


//=== Хвост ===

function  inkSLL_cutNodeLast(var CLL:pointer):pointer;                          {$ifdef _INLINE_} inline; {$endif} overload;
function  inkSLL_cutNodeLast(var CLL:pointer; out  Count:tQueueCountNodes):pointer;{$ifdef _INLINE_} inline; {$endif} overload;
procedure inkSLL_insNodeLast(var CLL:pointer; const Node:pointer);              {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkSLL_insNodeLast(var CLL:pointer; const Node:pointer; out Count:tQueueCountNodes); {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkSLL_insListLast(var CLL:pointer; const List:pointer);              overload; {$ifdef _INLINE_} inline; {$endif}
procedure inkSLL_insListLast(var CLL:pointer; const List:pointer; out Count:tQueueCountNodes);            overload; {$ifdef _INLINE_} inline; {$endif}

//    == 2.8 МАССИВ ==

function  inkSLL_getNode      (const CLL:pointer; Index:tQueueCountNodes):pointer;                         {$ifdef _INLINE_} inline; {$endif}
function  inkSLL_getNodeOrLast(const CLL:pointer; Index:tQueueCountNodes):pointer;                         {$ifdef _INLINE_} inline; {$endif}
function  inkSLL_getIndex     (const CLL:pointer; const Node:pointer; out Index:tQueueCountNodes):boolean; {$ifdef _INLINE_} inline; {$endif}
procedure inkSLL_insNodeIndex (var   CLL:pointer; const Node:pointer; Index:tQueueCountNodes);             {$ifdef _INLINE_} inline; {$endif}
function  inkSLL_cutNodeIndex (var   CLL:pointer; Index:tQueueCountNodes):pointer;                         {$ifdef _INLINE_} inline; {$endif}
 *)
implementation

{$MACRO ON}

//****************************************************************************//
//                                                                            //
//                                                                   ЧАСТЬ #2 //
//                                                                            //
//****************************************************************************//

function inkQueue_getNext(const node:pointer):pointer;
begin
    result:=pQueueNode(Node)^.next;
end;

procedure inkQueue_setNext(const node:pointer; const next:pointer);
begin
    pQueueNode(Node)^.next:=next;
end;


procedure inkQueue_nodeDST(const node:pointer);
begin
    dispose(pQueueNode(Node));
end;

{$deFine _M_protoCLL_blockFNK__getNext:=inkQueue_getNext}
{$deFine _M_protoCLL_blockFNK__setNext:=inkQueue_setNext}


//------------------------------------------------------------------------------

{:::[00] ИНИЦИАЛИЗИРОВАТЬ, подготовить к работе.
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  ---
  * CLL сделана как out для "подавления" hint`ов при начальной инициализации
  :}
procedure inkCLL_INIT(out CLL:pointer);
begin
    CLL:=nil;
end;

//------------------------------------------------------------------------------

{:::[FFv2x0] быстро УНИЧТОЖИТЬ элементы в порядке: ВТОРОГО по ПОСЛЕДНИЙ, ПЕРВЫЙ
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  ---
  * уничтожение узлов типа pQueueNode => вообще говоря данныя функция
    написанна тока для тестов, и используется ТОЛЬКО в них
  * после выполнения CLL===@nil
  :}
procedure inkCLL_clean_fast(var CLL:pointer);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkCLL_clean_fast"'}{$endIF}
{$deFine _M_protoCLL_FFv2__var_FIRST  :=CLL}
{$deFine _M_protoCLL_FFv2__lcl_nodeDST:=inkQueue_nodeDST}
{$I 'protoCLL_bodyFNC__FFv2__CLEAR.inc'}

{:::[FFv2x1] быстро УНИЧТОЖИТЬ элементы в порядке <2,3..n,1>
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(disposePRC указатель на ФУНКЦИЮ уничтожения узла)
  ---
  * после выполнения CLL===@nil
  :}
procedure inkCLL_CLEAR_fast(var CLL:pointer; disposePRC:fInkSLL_doDispose);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkCLL_CLEAR_fast function"'}{$endIF}
{$deFine _M_protoCLL_FFv2__var_FIRST  :=CLL}
{$deFine _M_protoCLL_FFv2__lcl_nodeDST:=disposePRC}
{$I 'protoCLL_bodyFNC__FFv2__CLEAR.inc'}

{:::[FFv2x2] быстро УНИЧТОЖИТЬ элементы в порядке: ВТОРОГО по ПОСЛЕДНИЙ, ПЕРВЫЙ
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(disposePRC указатель на МЕТОД обЪекта уничтожения узла)
  ---
  * после выполнения CLL===@nil
  :}
procedure inkCLL_CLEAR_fast(var CLL:pointer; disposePRC:aInkSLL_doDispose);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkCLL_CLEAR_fast method"'}{$endIF}
{$deFine _M_protoCLL_FFv2__var_FIRST  :=CLL}
{$deFine _M_protoCLL_FFv2__lcl_nodeDST:=disposePRC}
{$I 'protoCLL_bodyFNC__FFv2__CLEAR.inc'}

//------------------------------------------------------------------------------

{:::[10] очередь ПУСТая?
  @param (CLL переменная-ссылко-указатель на первый узел списка)
  @result(@true -- да, очередь Пуста; @false -- ЕСТЬ элементы)
  :}
function inkCLL_isEmpty(const CLL:pointer):boolean;
begin
    result:=CLL=nil;
end;

//------------------------------------------------------------------------------

{:::[11] ПОсчитать количество узлов (путем прямого перебора)
  @param (CLL переменная-ссылко-указатель на первый узел списка)
  @return(количество узлов)
  :}
function inkCLL_clcCount(const CLL:pointer):tQueueCountNodes;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkСLL_Count"'}{$endIF}
{$deFine _M_protoCLL_11__cst_FIRST:=CLL}
{$deFine _M_protoCLL_11__out_COUNT:=result}
{$I 'protoCLL_bodyFNC__11__Count.inc'}


//------------------------------------------------------------------------------

{:::[20x1] перечислить (посетить КАЖДЫЙ узел в порядке с ПЕРВОГО по ПОСЛЕДНИЙ)
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(enumData указатель на "информацию", передаваемую в enumFNC для каждого узла)
  @param(enumFNC указатель на "callBack" функцию, вызываемую для КАЖДОГО узла)
  @returns(@nil -- обошли ВСЮ очередь, иначе ссылка-указатель на последний посещенный узел)
  :}
function inkCLL_Enumerate(const CLL:pointer; const enumData:pointer; const enumFNC:fInkSLL_doProcess):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_Enumerate"'}{$endIF}
{$deFine _M_protoCLL_20__cst_FIRST   :=CLL}
{$deFine _M_protoCLL_20__cst_enumData:=enumData}
{$deFine _M_protoCLL_20__cst_enumFNC :=enumFNC}
{$deFine _M_protoCLL_20__out_LAST    :=result}
{$I 'protoCLL_bodyFNC__20__Enumerate.inc'}

{:::[20x2] перечислить (посетить КАЖДЫЙ узел в порядке с ПЕРВОГО по ПОСЛЕДНИЙ)
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(enumData указатель на "информацию", передаваемую в enumFNC для каждого узла)
  @param(enumFNC указатель на "callBack" функцию, вызываемую для КАЖДОГО узла)
  @returns(@nil -- обошли ВСЮ очередь, иначе ссылка-указатель [pQueueNode] на последний посещенный узел)
  :}
function inkCLL_Enumerate(const CLL:pointer; const enumData:pointer; const enumFNC:aInkSLL_doProcess):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_Enumerate"'}{$endIF}
{$deFine _M_protoCLL_20__cst_FIRST   :=CLL}
{$deFine _M_protoCLL_20__cst_enumData:=enumData}
{$deFine _M_protoCLL_20__cst_enumFNC :=enumFNC}
{$deFine _M_protoCLL_20__out_LAST    :=result}
{$I 'protoCLL_bodyFNC__20__Enumerate.inc'}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(*
{:::[69] изменить порядок следования узлов списка на ОБРАТНЫЙ.
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  :}
procedure inkSLL_Invert(var CLL:pointer);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_Invert"'}{$endIF}
{$deFine _M_protoCLL_69__var_FIRST:=CLL}
{$I 'protoSLL_bodyFNC__69__Invert.inc'}


//------------------------------------------------------------------------------

{:::[05v1] ПОСЛЕДНИЙ элемент списка (путем прямого перебора)
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @returns(ссылко-указатель на ПОСЛЕДНИЙ узел списка)
  :}
function inkSLL_getLast(const CLL:pointer):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_getLast"'}{$endIF}
{$deFine _M_protoCLL_05v1__cst_FIRST:=CLL}
{$deFine _M_protoCLL_05v1__out_LAST :=result}
{$I 'protoSLL_bodyFNC__05v1__getLast.inc'}

{:::[05v2][простой связный Список][Singly Linked Lists]
  ПОСЛЕДНИЙ элемент списка (путем прямого перебора), и общее кол-во элементов
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Count вернется количество узлов списка)
  @returns(ссылко-указатель на ПОСЛЕДНИЙ узел списка)
  :}
function inkSLL_getLast(const CLL:pointer; out Count:tQueueCountNodes):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_getLast count"'}{$endIF}
{$deFine _M_protoCLL_05v2__cst_FIRST:=CLL}
{$deFine _M_protoCLL_05v2__out_COUNT:=Count}
{$deFine _M_protoCLL_05v2__out_LAST :=result}
{$I 'protoSLL_bodyFNC__05v2__getLast.inc'}

//------------------------------------------------------------------------------

{:::[C0v1] вырезать УЗЕЛ
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node ВЫРЕЗАЕМЫЙ элемент списка)
  :}
procedure inkSLL_cutNode(var CLL:pointer; const Node:pointer);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_cutNode"'}{$endIF}
{$deFine _M_protoCLL_C0v1__var_FIRST:=CLL}
{$deFine _M_protoCLL_C0v1__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__C0v1__cutNode.inc'}

{:::[C0v2] вырезать УЗЕЛ
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node ВЫРЕЗАЕМЫЙ элемент списка)
  @returns(@true -- элемент найден и вырезан; @false -- элемент НЕ найден => НЕвырезался)
  :}
function  inkSLL_cutNodeRES(var CLL:pointer; const Node:pointer):boolean;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_cutNode RES"'}{$endIF}
{$deFine _M_protoCLL_C0v2__var_FIRST:=CLL}
{$deFine _M_protoCLL_C0v2__cst_NODE :=Node}
{$deFine _M_protoCLL_C0v2__out_RES  :=result}
{$I 'protoSLL_bodyFNC__C0v2__cutNode.inc'}

//------------------------------------------------------------------------------

{:::[С1] вырезать УЗЕЛ из Начала списка
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @returns(вырезанный Первый УЗЕЛ)
  ---
  # result^.next=?=@nil (тоесть скорее всего НЕ NIL)
  :}
function inkSLL_cutNodeFirst(var CLL:pointer):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_cutNodeFirst"'}{$endIF}
{$deFine _M_protoCLL_C1__var_FIRST:=CLL}
{$deFine _M_protoCLL_C1__out_NODE :=result}
{$I 'protoSLL_bodyFNC__C1__cutNodeFirst.inc'}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[06] ВСТАВИТЬ элемент ПЕРВЫМ в списке
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkSLL_insNodeFirst(var CLL:pointer; const Node:pointer);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_insNodeFirst"'}{$endIF}
{$deFine _M_protoCLL_06__var_FIRST:=CLL}
{$deFine _M_protoCLL_06__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__06__insFirst.inc'}

{:::[07] ВСТАВИТЬ список СНАЧАЛА
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(List переменная-ссылко-указатель на первый узел вставляемого СПИСКА)
  :}
procedure inkSLL_insListFirst(var CLL:pointer; const List:pointer);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_insListFirst"'}{$endIF}
{$deFine _M_protoCLL_07__var_FIRST:=CLL}
{$deFine _M_protoCLL_07__cst_LIST :=List}
{$I 'protoSLL_bodyFNC__07__insFirst.inc'}

*)

//------------------------------------------------------------------------------

{:::[C2] вырезать ВТОРОЙ элемент списка
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @return(вырезанный ВТОРОЙ УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
function  inkCLL_cutNodeSecond(const CLL:pointer):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkCLL_cutNodeSecond"'}{$endIF}
{$deFine _M_protoCLL_C2__cst_FIRST:=CLL}
{$deFine _M_protoCLL_C2__out_NODE :=result}
{$I protoCLL_bodyFNC__C2__cutNodeSecond.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(*
{:::[16] ВСТАВИТЬ список СНАЧАЛА
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(List переменная-ссылко-указатель на первый узел вставляемого СПИСКА)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkCLL_insNodeSecond(var CLL:pointer; const Node:pointer);
begin

end;
*)
(*
//------------------------------------------------------------------------------

{:::[CFv1] вырезать УЗЕЛ из КОНЦА списка
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @returns(вырезанный ПОСЛЕДНИЙ УЗЕЛ)
  ---
  # случай CLL==@NIL НЕ проверяется
  :}
function inkSLL_cutNodeLast(var CLL:pointer):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_cutNodeLast"'}{$endIF}
{$deFine _M_protoCLL_CFv1__var_FIRST:=CLL}
{$deFine _M_protoCLL_CFv1__out_LAST :=result}
{$I 'protoSLL_bodyFNC__CFv1__cutNodeLast.inc'}


{:::[CFv2] вырезать УЗЕЛ из КОНЦА списка
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @returns(вырезанный ПОСЛЕДНИЙ УЗЕЛ)
  ---
  # случай CLL==@NIL НЕ проверяется
  :}
function inkSLL_cutNodeLast(var CLL:pointer; out Count:tQueueCountNodes):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_cutNodeLast_count"'}{$endIF}
{$deFine _M_protoCLL_0Dv2__var_FIRST:=CLL}
{$deFine _M_protoCLL_0Dv2__out_COUNT:=Count}
{$deFine _M_protoCLL_0Dv2__out_LAST :=result}
{$I 'protoSLL_bodyFNC__0Dv2__cutNodeLast_count.inc'}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[08v1] ВСТАВИТЬ элемент ПОСЛЕДНИМ в списке
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkSLL_insNodeLast(var CLL:pointer; const Node:pointer);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_insNodeLast"'}{$endIF}
{$deFine _M_protoCLL_08v1__var_FIRST:=CLL}
{$deFine _M_protoCLL_08v1__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__08v1__insLast.inc'}

{:::[08v2] ВСТАВИТЬ элемент ПОСЛЕДНИМ в списке
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Count вернется количество узлов списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkSLL_insNodeLast(var CLL:pointer; const Node:pointer; out Count:tQueueCountNodes);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_insNodeLast count"'}{$endIF}
{$deFine _M_protoCLL_08v2__var_FIRST:=CLL}
{$deFine _M_protoCLL_08v2__out_COUNT:=Count}
{$deFine _M_protoCLL_08v2__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__08v2__insLast.inc'}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[09v1] ВСТАВИТЬ ПОДсписок ПОСЛЕДНИМ в списке
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkSLL_insListLast(var CLL:pointer; const List:pointer);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_insListLast"'}{$endIF}
{$deFine _M_protoCLL_09v1__var_FIRST:=CLL}
{$deFine _M_protoCLL_09v1__cst_LIST :=List}
{$I 'protoSLL_bodyFNC__09v1__insLast.inc'}

{:::[09v2] ВСТАВИТЬ ПОДсписок ПОСЛЕДНИМ в списке
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Count вернется количество узлов списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkSLL_insListLast(var CLL:pointer; const List:pointer; out Count:tQueueCountNodes);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_insNodeLast"'}{$endIF}
{$deFine _M_protoCLL_09v2__var_FIRST:=CLL}
{$deFine _M_protoCLL_09v2__out_COUNT:=Count}
{$deFine _M_protoCLL_09v2__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__09v2__insLast.inc'}

//------------------------------------------------------------------------------

{:::[A1v1] элемент с Индексом
    @param(CLL переменная-ссылко-указатель на первый узел списка)
    @param(Index вернется количество узлов списка)
    @returns(ссылко-указатель на узел списка)
 :::}
function inkSLL_getNode(const CLL:pointer; index:tQueueCountNodes):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_getNode"'}{$endIF}
{$deFine _M_protoCLL_A1v1__cst_FIRST:=CLL}
{$deFine _M_protoCLL_A1v1__var_Index:=index}
{$deFine _M_protoCLL_A1v1__out_NODE :=result}
{$I 'protoSLL_bodyFNC__A1v1__getNode.inc'}

{:::[A1v2] элемент с Индексом или последний
    @param(CLL переменная-ссылко-указатель на первый узел списка)
    @param(Index вернется количество узлов списка)
    @returns(ссылко-указатель на узел списка)
 :::}
function inkSLL_getNodeOrLast(const CLL:pointer; Index:tQueueCountNodes):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_getNode_orLast"'}{$endIF}
{$deFine _M_protoCLL_A1v2__cst_FIRST:=CLL}
{$deFine _M_protoCLL_A1v2__var_Index:=index}
{$deFine _M_protoCLL_A1v2__out_NODE :=result}
{$I 'protoSLL_bodyFNC__A1v2__getNodeOrLast.inc'}

//------------------------------------------------------------------------------

{:::[A2] элемент с Индексом
    @param(CLL переменная-ссылко-указатель на первый узел списка)
    @param(Node искомый элемент)
    @returns(индекс Элемента; ели нет то 0-1)
 :::}
function inkSLL_getIndex(const CLL:pointer; const Node:pointer; out Index:tQueueCountNodes):boolean;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_getIndex"'}{$endIF}
{$deFine _M_protoCLL_0B__cst_FIRST :=CLL}
{$deFine _M_protoCLL_0B__cst_NODE  :=Node}
{$deFine _M_protoCLL_0B__out_INDEX :=index}
{$deFine _M_protoCLL_0B__out_RESULT:=result}
{$I 'protoSLL_bodyFNC__0B__getIndex.inc'}

//------------------------------------------------------------------------------

{:::[A3] ВСТАВИТЬ элементом c ИНДЕКСОМ
    @param(CLL переменная-ссылко-указатель на первый узел списка)
    @param(Node искомый элемент)
    @returns(индекс Элемента; ели нет то 0-1)
 :::}
procedure inkSLL_insNodeIndex(var CLL:pointer; const Node:pointer; Index:tQueueCountNodes);
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_insNodeIndex"'}{$endIF}
{$deFine _M_protoCLL_A3__var_FIRST:=CLL}
{$deFine _M_protoCLL_A3__cst_NODE :=Node}
{$deFine _M_protoCLL_A3__var_INDEX:=index}
{$I 'protoSLL_bodyFNC__A3__insNodeIndex.inc'}

//------------------------------------------------------------------------------

{:::[A5v1] ВЫРЕЗАТЬ элемент c ИНДЕКСОМ
    @param(CLL переменная-ссылко-указатель на первый узел списка)
    @param(Index индекс ВЫРЕЗАЕМОГО элемента)
    @returns()
    ---
    # в результате выполнения result^.Next<>nil
 :::}
function inkSLL_cutNodeIndex(var CLL:pointer; Index:tQueueCountNodes):pointer;
{$ifDef inkCLL_FncSrcMessage}{$message 'source function "inkSLL_insNodeIndex"'}{$endIF}
{$deFine _M_protoCLL_A5v1__var_FIRST:=CLL}
{$deFine _M_protoCLL_A5v1__var_INDEX:=index}
{$deFine _M_protoCLL_A5v1__out_NODE :=result}
{$I 'protoSLL_bodyFNC__A5v1__insNodeIndex.inc'}
    *)
end.
