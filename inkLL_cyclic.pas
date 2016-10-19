unit inkLL_cyclic;
{<*** Cyclic Linked Lists
    * библиокека для работы с "Циклическими Связными Списками"
    *}
{//..................................................[ in0k © 13.01.2013 ]...///
///                              _____                                       ///
///                      Cyclic |   __|_ _ first -> -                        ///
///                      Linked |  |__| | |         -                        ///
///                      Lists  |_____|_|_|         -                        ///
///                              v 0.91    first <- =                        ///
///                                                                          ///
///...........................................[ v 0.91 in0k © 28.05.2013 ]...//}


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

    E4    - очистка узлов удовлетворяющих условию

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
{$define inkLLcyclic_fncHeadMessage} //< сообщения о текущей процедуре, с ними проще ловить ошибки
{$endif}
uses {$ifOpt D+}sysutils,{$endif} //< попытка отлова ДИНАМИЧЕСКИХ ошибок
    inkLL_node;

//****************************************************************************//
//                                                                            //
//                                                                   ЧАСТЬ #1 //
//                                                                            //
//****************************************************************************//


//****************************************************************************//
//                                                                            //
//                                                                   ЧАСТЬ #2 //
//                                                                            //
//****************************************************************************//

//== 2.0-F рождение и смерть ==

procedure inkLLc_INIT(out CLL:pointer);                                         {$ifdef _INLINE_} inline; {$endif}

procedure inkLLc_CLEAR_fast(var CLL:pointer; const disposePRC:fInkNodeLL_doDispose);  {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLc_CLEAR_fast(var CLL:pointer; const disposePRC:aInkNodeLL_doDispose);  {$ifdef _INLINE_} inline; {$endif} overload;

procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:fInkNodeLL_doProcess; const DspPRC:fInkNodeLL_doDispose); {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:fInkNodeLL_doProcess; const DspPRC:aInkNodeLL_doDispose); {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:aInkNodeLL_doProcess; const DspPRC:fInkNodeLL_doDispose); {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:aInkNodeLL_doProcess; const DspPRC:aInkNodeLL_doDispose); {$ifdef _INLINE_} inline; {$endif} overload;

//== 2.2 текущие/очевидные свойства списка ==

function  inkLLc_Present (const CLL:pointer):boolean;                           {$ifdef _INLINE_} inline; {$endif}
function  inkLLc_isEmpty (const CLL:pointer):boolean;                           {$ifdef _INLINE_} inline; {$endif}
function  inkLLc_clcCount(const CLL:pointer):tInkLLNodeCount;                   {$ifdef _INLINE_} inline; {$endif}

//== 2.3 от кончика ушей до пят (операции над ВСЕМ списком) ==

function  inkLLc_Enumerate(const CLL:pointer; const Context:pointer; const EnumFNC:fInkNodeLL_doProcess):pointer; {$ifdef _INLINE_} inline; {$endif} overload;
function  inkLLc_Enumerate(const CLL:pointer; const Context:pointer; const EnumFNC:aInkNodeLL_doProcess):pointer; {$ifdef _INLINE_} inline; {$endif} overload;
(*procedure inkLLc_Invert   (var   CLL:pointer);                                                                  {$ifdef _INLINE_} inline; {$endif}

//== 2.5 последний Герой (последний узел списка) ==

function  inkLLc_getLast(const CLL:pointer):pointer;                            {$ifdef _INLINE_} inline; {$endif} overload;
function  inkLLc_getLast(const CLL:pointer; out Count:tQueueCountNodes):pointer;{$ifdef _INLINE_} inline; {$endif} overload;

*)
//== 2.6 вырезать "МЕНЯ" ==

procedure inkLLc_cutNode   (var CLL:pointer; const Node:pointer);               {$ifdef _INLINE_} inline; {$endif} overload;
function  inkLLc_cutNodeRes(var CLL:pointer; const Node:pointer):boolean;       {$ifdef _INLINE_} inline; {$endif} overload;

(*
//== 2.7 Грива и Хвост (вставка/удаление из начала и конца СПИСКА) ==

//=== Грива ===

function  inkLLc_cutNodeFirst(var CLL:pointer):pointer;                         {$ifdef _INLINE_} inline; {$endif}
procedure inkLLc_insNodeFirst(var CLL:pointer; const Node:pointer);             {$ifdef _INLINE_} inline; {$endif}
procedure inkLLc_insListFirst(var CLL:pointer; const List:pointer);             {$ifdef _INLINE_} inline; {$endif}

*)
//=== ШЕЯ ===

function  inkLLc_cutNodeSecond(const CLL:pointer):pointer;                      {$ifdef _INLINE_} inline; {$endif}
procedure inkLLc_insNodeSecond(var CLL:pointer; const Node:pointer);            {$ifdef _INLINE_} inline; {$endif}

//function  inkLLc_getSecond  (const CLL:pointer):pointer;                      {$ifdef _INLINE_} inline; {$endif}
//function  inkLLc_getPrevious(const CLL:pointer):pointer;                      {$ifdef _INLINE_} inline; {$endif}


function  inkLLcl_InsNode (var   CLL:pointer; const Node:pointer):pointer;  {$ifdef _INLINE_} inline; {$endif}
function  inkLLcl_getFirst(const CLL:pointer):pointer;                      {$ifdef _INLINE_} inline; {$endif}
function  inkLLcl_getNext (const CLL:pointer; const Node:pointer):pointer;  {$ifdef _INLINE_} inline; {$endif}


(*


//=== Хвост ===

function  inkLLc_cutNodeLast(var CLL:pointer):pointer;                          {$ifdef _INLINE_} inline; {$endif} overload;
function  inkLLc_cutNodeLast(var CLL:pointer; out  Count:tInkLLNodeCount):pointer;{$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLc_insNodeLast(var CLL:pointer; const Node:pointer);              {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLc_insNodeLast(var CLL:pointer; const Node:pointer; out Count:tInkLLNodeCount); {$ifdef _INLINE_} inline; {$endif} overload;
procedure inkLLc_insListLast(var CLL:pointer; const List:pointer);              overload; {$ifdef _INLINE_} inline; {$endif}
procedure inkLLc_insListLast(var CLL:pointer; const List:pointer; out Count:tInkLLNodeCount);            overload; {$ifdef _INLINE_} inline; {$endif}

//    == 2.8 МАССИВ ==

function  inkLLc_getNode      (const CLL:pointer; Index:tInkLLNodeIndex):pointer;                         {$ifdef _INLINE_} inline; {$endif}
function  inkLLc_getNodeOrLast(const CLL:pointer; Index:tInkLLNodeIndex):pointer;                         {$ifdef _INLINE_} inline; {$endif}
function  inkLLc_getIndex     (const CLL:pointer; const Node:pointer; out Index:tInkLLNodeIndex):boolean; {$ifdef _INLINE_} inline; {$endif}
procedure inkLLc_insNodeIndex (var   CLL:pointer; const Node:pointer; Index:tInkLLNodeIndex);             {$ifdef _INLINE_} inline; {$endif}
function  inkLLc_cutNodeIndex (var   CLL:pointer; Index:tInkLLNodeIndex):pointer;                         {$ifdef _INLINE_} inline; {$endif}
 *)
implementation

function inkNodeLLc_getNext(const node:pointer):pointer; {$ifdef _INLINE_} inline; {$endif}
begin
    result:=InkNodeLL_getNext(node);
end;

procedure inkNodeLLc_setNext(const node,next:pointer);   {$ifdef _INLINE_} inline; {$endif}
begin
    InkNodeLL_setNext(node,next);
end;

//****************************************************************************//
//                                                                            //
//                                                                   ЧАСТЬ #2 //
//                                                                            //
//****************************************************************************//

{$MACRO ON}
{$deFine _M_protoInkLLc_blockFNK__GetNext:=inkNodeLLc_getNext}
{$deFine _M_protoInkLLc_blockFNK__SetNext:=inkNodeLLc_setNext}
{.$deFine _M_protoInkLLc_blockFNK__NodeDST:=''} //< чтобы ПОМНИТЬ


//------------------------------------------------------------------------------

{:::[00] ИНИЦИАЛИЗИРОВАТЬ, подготовить к работе.
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  ---
  * CLL сделана как out для "подавления" hint`ов при начальной инициализации
  :}
procedure inkLLc_INIT(out CLL:pointer);
begin
    CLL:=nil;
end;

//------------------------------------------------------------------------------

{:::[FFv2x1] быстро УНИЧТОЖИТЬ элементы в порядке <2,3..n,1>
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(disposePRC указатель на ФУНКЦИЮ уничтожения узла)
  ---
  * после выполнения CLL===@nil
  :}
procedure inkLLc_CLEAR_fast(var CLL:pointer; const disposePRC:fInkNodeLL_doDispose);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLc_CLEAR_fast function'}{$endIF}
var tmp:pointer; //< для удобства навигации
{$deFine _m_protoInkLLc_FFv2__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLc_FFv2__var_FIRST  :=CLL}
{$deFine _M_protoInkLLc_FFv2__lcl_nodeDST:=disposePRC}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_FFv2__CLEAR.inc}
end;

{:::[FFv2x2] быстро УНИЧТОЖИТЬ элементы в порядке: ВТОРОГО по ПОСЛЕДНИЙ, ПЕРВЫЙ
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(disposePRC указатель на МЕТОД обЪекта уничтожения узла)
  ---
  * после выполнения CLL===@nil
  :}
procedure inkLLc_CLEAR_fast(var CLL:pointer; const disposePRC:aInkNodeLL_doDispose);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLc_CLEAR_fast method'}{$endIF}
var tmp:pointer; //< для удобства навигации
{$deFine _m_protoInkLLc_FFv2__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLc_FFv2__var_FIRST  :=CLL}
{$deFine _M_protoInkLLc_FFv2__lcl_nodeDST:=disposePRC}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_FFv2__CLEAR.inc}
end;

//------------------------------------------------------------------------------

procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:fInkNodeLL_doProcess; const DspPRC:fInkNodeLL_doDispose);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLs_Erase_fast xff'}{$endIF}
var tmp,tmq:pointer;
{$deFine _m_protoInkLLc_E4__tmp_POINTER0:=tmp}
{$deFine _m_protoInkLLc_E4__tmp_POINTER1:=tmq}
{$deFine _M_protoInkLLc_E4__var_FIRST   :=SLL}
{$deFine _M_protoInkLLc_E4__cst_cmpCTX  :=CmpCXT}
{$deFine _M_protoInkLLc_E4__lcl_cmpFNC  :=CmpFNC}
{$deFine _M_protoInkLLc_E4__lcl_dspPRC  :=DspPRC}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_E4__Erase.inc}
end;

procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:fInkNodeLL_doProcess; const DspPRC:aInkNodeLL_doDispose);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLs_Erase_fast xff'}{$endIF}
var tmp,tmq:pointer;
{$deFine _m_protoInkLLc_E4__tmp_POINTER0:=tmp}
{$deFine _m_protoInkLLc_E4__tmp_POINTER1:=tmq}
{$deFine _M_protoInkLLc_E4__var_FIRST   :=SLL}
{$deFine _M_protoInkLLc_E4__cst_cmpCTX  :=CmpCXT}
{$deFine _M_protoInkLLc_E4__lcl_cmpFNC  :=CmpFNC}
{$deFine _M_protoInkLLc_E4__lcl_dspPRC  :=DspPRC}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_E4__Erase.inc}
end;

procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:aInkNodeLL_doProcess; const DspPRC:fInkNodeLL_doDispose);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLs_Erase_fast xff'}{$endIF}
var tmp,tmq:pointer;
{$deFine _m_protoInkLLc_E4__tmp_POINTER0:=tmp}
{$deFine _m_protoInkLLc_E4__tmp_POINTER1:=tmq}
{$deFine _M_protoInkLLc_E4__var_FIRST   :=SLL}
{$deFine _M_protoInkLLc_E4__cst_cmpCTX  :=CmpCXT}
{$deFine _M_protoInkLLc_E4__lcl_cmpFNC  :=CmpFNC}
{$deFine _M_protoInkLLc_E4__lcl_dspPRC  :=DspPRC}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_E4__Erase.inc}
end;

procedure inkLLc_Erase_fast(var SLL:pointer; const CmpCXT:pointer; const CmpFNC:aInkNodeLL_doProcess; const DspPRC:aInkNodeLL_doDispose);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLs_Erase_fast xff'}{$endIF}
var tmp,tmq:pointer;
{$deFine _m_protoInkLLc_E4__tmp_POINTER0:=tmp}
{$deFine _m_protoInkLLc_E4__tmp_POINTER1:=tmq}
{$deFine _M_protoInkLLc_E4__var_FIRST   :=SLL}
{$deFine _M_protoInkLLc_E4__cst_cmpCTX  :=CmpCXT}
{$deFine _M_protoInkLLc_E4__lcl_cmpFNC  :=CmpFNC}
{$deFine _M_protoInkLLc_E4__lcl_dspPRC  :=DspPRC}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_E4__Erase.inc}
end;

//------------------------------------------------------------------------------

function inkLLc_Present(const CLL:pointer):boolean;
begin
    result:=Assigned(CLL);
end;

{:::[10] очередь ПУСТая?
  @param (CLL переменная-ссылко-указатель на первый узел списка)
  @result(@true -- да, очередь Пуста; @false -- ЕСТЬ элементы)
  :}
function inkLLc_isEmpty(const CLL:pointer):boolean;
begin
    result:=CLL=nil;
end;

//------------------------------------------------------------------------------

{:::[11] ПОсчитать количество узлов (путем прямого перебора)
  @param (CLL переменная-ссылко-указатель на первый узел списка)
  @return(количество узлов)
  :}
function inkLLc_clcCount(const CLL:pointer):tInkLLNodeCount;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLc_clcCount'}{$endIF}
var tmp:pointer; //< для удобства навигации
{$deFine _m_protoInkLLc_11__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLc_11__cst_FIRST  :=CLL}
{$deFine _M_protoInkLLc_11__out_COUNT  :=result}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_11__Count.inc}
end;


//------------------------------------------------------------------------------

{:::[20x1] перечислить (посетить КАЖДЫЙ узел в порядке с ПЕРВОГО по ПОСЛЕДНИЙ)
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Context указатель на "информацию", передаваемую в EnumFNC для каждого узла)
  @param(EnumFNC указатель на "callBack" функцию, вызываемую для КАЖДОГО узла)
  @returns(@nil -- обошли ВСЮ очередь, иначе ссылка-указатель на последний посещенный узел)
  :}
function inkLLc_Enumerate(const CLL:pointer; const Context:pointer; const EnumFNC:fInkNodeLL_doProcess):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLc_Enumerate function'}{$endIF}
{$deFine _M_protoInkLLc_20__cst_FIRST  :=CLL}
{$deFine _M_protoInkLLc_20__cst_context:=Context}
{$deFine _M_protoInkLLc_20__cst_enumFNC:=EnumFNC}
{$deFine _M_protoInkLLc_20__out_LAST   :=result}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_20__Enumerate.inc}
end;

{:::[20x2] перечислить (посетить КАЖДЫЙ узел в порядке с ПЕРВОГО по ПОСЛЕДНИЙ)
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Context указатель на "информацию", передаваемую в EnumFNC для каждого узла)
  @param(EnumFNC указатель на "callBack" функцию, вызываемую для КАЖДОГО узла)
  @returns(@nil -- обошли ВСЮ очередь, иначе ссылка-указатель [pQueueNode] на последний посещенный узел)
  :}
function inkLLc_Enumerate(const CLL:pointer; const Context:pointer; const EnumFNC:aInkNodeLL_doProcess):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLc_Enumerate method'}{$endIF}
{$deFine _M_protoInkLLc_20__cst_FIRST  :=CLL}
{$deFine _M_protoInkLLc_20__cst_context:=Context}
{$deFine _M_protoInkLLc_20__cst_enumFNC:=EnumFNC}
{$deFine _M_protoInkLLc_20__out_LAST   :=result}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_20__Enumerate.inc}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(*
{:::[69] изменить порядок следования узлов списка на ОБРАТНЫЙ.
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  :}
procedure inkLLc_Invert(var CLL:pointer);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_Invert"'}{$endIF}
{$deFine _M_protoInkLLc_69__var_FIRST:=CLL}
{$I 'protoSLL_bodyFNC__69__Invert.inc}


//------------------------------------------------------------------------------

{:::[05v1] ПОСЛЕДНИЙ элемент списка (путем прямого перебора)
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @returns(ссылко-указатель на ПОСЛЕДНИЙ узел списка)
  :}
function inkLLc_getLast(const CLL:pointer):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_getLast"'}{$endIF}
{$deFine _M_protoInkLLc_05v1__cst_FIRST:=CLL}
{$deFine _M_protoInkLLc_05v1__out_LAST :=result}
{$I 'protoSLL_bodyFNC__05v1__getLast.inc}

{:::[05v2][простой связный Список][Singly Linked Lists]
  ПОСЛЕДНИЙ элемент списка (путем прямого перебора), и общее кол-во элементов
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Count вернется количество узлов списка)
  @returns(ссылко-указатель на ПОСЛЕДНИЙ узел списка)
  :}
function inkLLc_getLast(const CLL:pointer; out Count:tQueueCountNodes):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_getLast count"'}{$endIF}
{$deFine _M_protoInkLLc_05v2__cst_FIRST:=CLL}
{$deFine _M_protoInkLLc_05v2__out_COUNT:=Count}
{$deFine _M_protoInkLLc_05v2__out_LAST :=result}
{$I 'protoSLL_bodyFNC__05v2__getLast.inc}

*)
//------------------------------------------------------------------------------

{:::[C0v1] вырезать УЗЕЛ
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node ВЫРЕЗАЕМЫЙ элемент списка)
  :}
procedure inkLLc_cutNode(var CLL:pointer; const Node:pointer);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLc_cutNode'}{$endIF}
var tmp:pointer;
{$deFine _m_protoInkLLc_C0v1__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLc_C0v1__var_FIRST  :=CLL}
{$deFine _M_protoInkLLc_C0v1__cst_NODE   :=Node}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_C0v1__cutNode.inc}
end;

{:::[C0v2] вырезать УЗЕЛ
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node ВЫРЕЗАЕМЫЙ элемент списка)
  @returns(@true -- элемент найден и вырезан; @false -- элемент НЕ найден => НЕвырезался)
  :}
function  inkLLc_cutNodeRES(var CLL:pointer; const Node:pointer):boolean;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLc_cutNodeRES'}{$endIF}
var tmp:pointer;
{$deFine _m_protoInkLLc_C0v2__tmp_POINTER:=tmp}
{$deFine _M_protoInkLLc_C0v2__var_FIRST  :=CLL}
{$deFine _M_protoInkLLc_C0v2__cst_NODE   :=Node}
{$deFine _M_protoInkLLc_C0v2__out_RES    :=result}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_C0v2__cutNodeRES.inc}
end;

(*
//------------------------------------------------------------------------------

{:::[С1] вырезать УЗЕЛ из Начала списка
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @returns(вырезанный Первый УЗЕЛ)
  ---
  # result^.next=?=@nil (тоесть скорее всего НЕ NIL)
  :}
function inkLLc_cutNodeFirst(var CLL:pointer):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_cutNodeFirst"'}{$endIF}
{$deFine _M_protoInkLLc_C1__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_C1__out_NODE :=result}
{$I 'protoSLL_bodyFNC__C1__cutNodeFirst.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[06] ВСТАВИТЬ элемент ПЕРВЫМ в списке
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkLLc_insNodeFirst(var CLL:pointer; const Node:pointer);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_insNodeFirst"'}{$endIF}
{$deFine _M_protoInkLLc_06__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_06__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__06__insFirst.inc}

{:::[07] ВСТАВИТЬ список СНАЧАЛА
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(List переменная-ссылко-указатель на первый узел вставляемого СПИСКА)
  :}
procedure inkLLc_insListFirst(var CLL:pointer; const List:pointer);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_insListFirst"'}{$endIF}
{$deFine _M_protoInkLLc_07__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_07__cst_LIST :=List}
{$I 'protoSLL_bodyFNC__07__insFirst.inc}

*)

//------------------------------------------------------------------------------

{:::[C2] вырезать ВТОРОЙ элемент списка
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @return(вырезанный ВТОРОЙ УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
function  inkLLc_cutNodeSecond(const CLL:pointer):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLc_cutNodeSecond'}{$endIF}
{$deFine _M_protoInkLLc_C2__cst_FIRST:=CLL}
{$deFine _M_protoInkLLc_C2__out_NODE :=result}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_C2__cutNodeSecond.inc}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[16] вставить узел ВТОРЫМ элементом
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node указатель на добавляемый узел)
  ---
  # если CLL -- пуст, то встанет ПЕРВЫМ
  :}
procedure inkLLc_insNodeSecond(var CLL:pointer; const Node:pointer);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLc_insNodeSecond'}{$endIF}
{$deFine _M_protoInkLLc_16__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_16__cst_NODE :=Node}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_16__insNodeSecond.inc}
end;


function  inkLLcl_InsNode (var CLL:pointer; const Node:pointer):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'inkLLcl_InsNode'}{$endIF}
{$deFine _M_protoInkLLc_16__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_16__cst_NODE :=Node}
begin //< для удобства навигации
{$I protoInkLLc_bodyFNC_16__insNodeSecond.inc}
CLL:=Node;
end;


(*
//------------------------------------------------------------------------------

{:::[CFv1] вырезать УЗЕЛ из КОНЦА списка
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @returns(вырезанный ПОСЛЕДНИЙ УЗЕЛ)
  ---
  # случай CLL==@NIL НЕ проверяется
  :}
function inkLLc_cutNodeLast(var CLL:pointer):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_cutNodeLast"'}{$endIF}
{$deFine _M_protoInkLLc_CFv1__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_CFv1__out_LAST :=result}
{$I 'protoSLL_bodyFNC__CFv1__cutNodeLast.inc}


{:::[CFv2] вырезать УЗЕЛ из КОНЦА списка
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @returns(вырезанный ПОСЛЕДНИЙ УЗЕЛ)
  ---
  # случай CLL==@NIL НЕ проверяется
  :}
function inkLLc_cutNodeLast(var CLL:pointer; out Count:tQueueCountNodes):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_cutNodeLast_count"'}{$endIF}
{$deFine _M_protoInkLLc_0Dv2__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_0Dv2__out_COUNT:=Count}
{$deFine _M_protoInkLLc_0Dv2__out_LAST :=result}
{$I 'protoSLL_bodyFNC__0Dv2__cutNodeLast_count.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[08v1] ВСТАВИТЬ элемент ПОСЛЕДНИМ в списке
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkLLc_insNodeLast(var CLL:pointer; const Node:pointer);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_insNodeLast"'}{$endIF}
{$deFine _M_protoInkLLc_08v1__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_08v1__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__08v1__insLast.inc}

{:::[08v2] ВСТАВИТЬ элемент ПОСЛЕДНИМ в списке
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Count вернется количество узлов списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkLLc_insNodeLast(var CLL:pointer; const Node:pointer; out Count:tQueueCountNodes);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_insNodeLast count"'}{$endIF}
{$deFine _M_protoInkLLc_08v2__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_08v2__out_COUNT:=Count}
{$deFine _M_protoInkLLc_08v2__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__08v2__insLast.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{:::[09v1] ВСТАВИТЬ ПОДсписок ПОСЛЕДНИМ в списке
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkLLc_insListLast(var CLL:pointer; const List:pointer);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_insListLast"'}{$endIF}
{$deFine _M_protoInkLLc_09v1__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_09v1__cst_LIST :=List}
{$I 'protoSLL_bodyFNC__09v1__insLast.inc}

{:::[09v2] ВСТАВИТЬ ПОДсписок ПОСЛЕДНИМ в списке
  @param(CLL переменная-ссылко-указатель на первый узел списка)
  @param(Count вернется количество узлов списка)
  @param(Node вставляемый УЗЕЛ)
  ---
  # проверки Node^.next==@nil НЕТ (точнее тока в DEBUG режиме)
  :}
procedure inkLLc_insListLast(var CLL:pointer; const List:pointer; out Count:tQueueCountNodes);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_insNodeLast"'}{$endIF}
{$deFine _M_protoInkLLc_09v2__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_09v2__out_COUNT:=Count}
{$deFine _M_protoInkLLc_09v2__cst_NODE :=Node}
{$I 'protoSLL_bodyFNC__09v2__insLast.inc}

//------------------------------------------------------------------------------

{:::[A1v1] элемент с Индексом
    @param(CLL переменная-ссылко-указатель на первый узел списка)
    @param(Index вернется количество узлов списка)
    @returns(ссылко-указатель на узел списка)
 :::}
function inkLLc_getNode(const CLL:pointer; index:tQueueCountNodes):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_getNode"'}{$endIF}
{$deFine _M_protoInkLLc_A1v1__cst_FIRST:=CLL}
{$deFine _M_protoInkLLc_A1v1__var_Index:=index}
{$deFine _M_protoInkLLc_A1v1__out_NODE :=result}
{$I 'protoSLL_bodyFNC__A1v1__getNode.inc}

{:::[A1v2] элемент с Индексом или последний
    @param(CLL переменная-ссылко-указатель на первый узел списка)
    @param(Index вернется количество узлов списка)
    @returns(ссылко-указатель на узел списка)
 :::}
function inkLLc_getNodeOrLast(const CLL:pointer; Index:tQueueCountNodes):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_getNode_orLast"'}{$endIF}
{$deFine _M_protoInkLLc_A1v2__cst_FIRST:=CLL}
{$deFine _M_protoInkLLc_A1v2__var_Index:=index}
{$deFine _M_protoInkLLc_A1v2__out_NODE :=result}
{$I 'protoSLL_bodyFNC__A1v2__getNodeOrLast.inc}

//------------------------------------------------------------------------------

{:::[A2] элемент с Индексом
    @param(CLL переменная-ссылко-указатель на первый узел списка)
    @param(Node искомый элемент)
    @returns(индекс Элемента; ели нет то 0-1)
 :::}
function inkLLc_getIndex(const CLL:pointer; const Node:pointer; out Index:tQueueCountNodes):boolean;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_getIndex"'}{$endIF}
{$deFine _M_protoInkLLc_0B__cst_FIRST :=CLL}
{$deFine _M_protoInkLLc_0B__cst_NODE  :=Node}
{$deFine _M_protoInkLLc_0B__out_INDEX :=index}
{$deFine _M_protoInkLLc_0B__out_RESULT:=result}
{$I 'protoSLL_bodyFNC__0B__getIndex.inc}

//------------------------------------------------------------------------------

{:::[A3] ВСТАВИТЬ элементом c ИНДЕКСОМ
    @param(CLL переменная-ссылко-указатель на первый узел списка)
    @param(Node искомый элемент)
    @returns(индекс Элемента; ели нет то 0-1)
 :::}
procedure inkLLc_insNodeIndex(var CLL:pointer; const Node:pointer; Index:tQueueCountNodes);
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_insNodeIndex"'}{$endIF}
{$deFine _M_protoInkLLc_A3__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_A3__cst_NODE :=Node}
{$deFine _M_protoInkLLc_A3__var_INDEX:=index}
{$I 'protoSLL_bodyFNC__A3__insNodeIndex.inc}

//------------------------------------------------------------------------------

{:::[A5v1] ВЫРЕЗАТЬ элемент c ИНДЕКСОМ
    @param(CLL переменная-ссылко-указатель на первый узел списка)
    @param(Index индекс ВЫРЕЗАЕМОГО элемента)
    @returns()
    ---
    # в результате выполнения result^.Next<>nil
 :::}
function inkLLc_cutNodeIndex(var CLL:pointer; Index:tQueueCountNodes):pointer;
{$ifDef inkLLcyclic_fncHeadMessage}{$message 'source function "inkSLL_insNodeIndex"'}{$endIF}
{$deFine _M_protoInkLLc_A5v1__var_FIRST:=CLL}
{$deFine _M_protoInkLLc_A5v1__var_INDEX:=index}
{$deFine _M_protoInkLLc_A5v1__out_NODE :=result}
{$I 'protoSLL_bodyFNC__A5v1__insNodeIndex.inc}
    *)











function inkLLcl_getFirst(const CLL:pointer):pointer;
begin
    result:=inkNodeLLc_getNext(CLL);
end;

function inkLLcl_getNext(const CLL:pointer; const Node:pointer):pointer;
begin
    if node<>CLL then result:=inkNodeLLc_getNext(Node)
    else result:=nil;
end;


end.
