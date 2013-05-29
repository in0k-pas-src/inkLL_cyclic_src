{//.[ PROto Cyclic Linked Lists].....................[ in0k © 13.01.2013 ]...///
///                                                                          ///
///                                _____                                     ///
///                     +-+-+-+-+-|   __|_ _ first -> -                      ///
///                     |  PROto  |  |__| | |         -                      ///
///                     +-+-+-+-+-|_____|_|_|         -                      ///
///                          v 2.0           first <- =                      ///
///                                                                          ///
///............................................[ v 2.0 in0k © 28.05.2013 ]...//}
{%region /fold 'check "define" for all used macros'                      }
    //--- VARs
    {$if defined (_M_protoInkLLc_C0v1__var_FIRST)}
        {$define _var_piLLcC0v1_FIRST:=_M_protoInkLLc_C0v1__var_FIRST}
    {$else}
        {$FATAL 'macro ".._FIRST" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_C0v1__cst_NODE)}
        {$define _cst_piLLcC0v1_NODE:=_M_protoInkLLc_C0v1__cst_NODE}
    {$else}
        {$FATAL 'macro ".._NODE" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoInkLLc_C0v1__lcl_getNext)}
        {$define _fnc_piLLcC0v1_getNext:=_M_protoInkLLc_C0v1__lcl_getNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__GetNext)}
        {$define _fnc_piLLcC0v1_getNext:=_M_protoInkLLc_blockFNK__GetNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_C0v1__lcl_setNext)}
        {$define _prc_piLLcC0v1_setNext:=_M_protoInkLLc_C0v1__lcl_setNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__SetNext)}
        {$define _prc_piLLcC0v1_setNext:=_M_protoInkLLc_blockFNK__SetNext}
    {$else}
        {$FATAL 'macro ".._setNext" : NOT define!'}
    {$endif}
{%endregion 'check "define" for all used macros' /fold}
{%region /fold 'setUP local vars'                                        }
{$if defined (_m_protoInkLLc_C0v1__tmp_POINTER)}
    {$define _tmp_piLLcC0v1_POINTER:=_m_protoInkLLc_C0v1__tmp_POINTER}
{$else}
var tmp:pointer;
    {$define _tmp_piLLcC0v1_POINTER:=tmp}
{$endif}
{%endregion 'setUP local vars' /fold}
begin
    //-- проверки
    {$ifOpt D+}
        {$if defined (_M_protoInkLLs_blockFNK__GetNext)}
            if _cst_piLLcC0v1_NODE=nil then begin
                raise Exception.CReate('_cst_piLLcC0v1_NODE==nil !!!');
            end;
        {$endif}
    {$endif}
    //-- агоритм-ритм-ритм
    if _var_piLLcC0v1_FIRST<>nil then begin //< имеет ли смысл работать
        if _fnc_piLLcC0v1_getNext(_var_piLLcC0v1_FIRST)<>_var_piLLcC0v1_FIRST then begin //< тоесть больше чем один элемент в списке
            // надо искать ПРЕДЫДУЩИЙ относительно _cst_piLLcC0v1_NODE
           _tmp_piLLcC0v1_POINTER:=_var_piLLcC0v1_FIRST;
            while (_fnc_piLLcC0v1_getNext(_tmp_piLLcC0v1_POINTER)<>_cst_piLLcC0v1_NODE)
            do begin
               _tmp_piLLcC0v1_POINTER:=_fnc_piLLcC0v1_getNext(_tmp_piLLcC0v1_POINTER);
                if _tmp_piLLcC0v1_POINTER=_var_piLLcC0v1_FIRST then BREAK;
            end;
            // если таки нашли, то вырезаем
            if _fnc_piLLcC0v1_getNext(_tmp_piLLcC0v1_POINTER)=_cst_piLLcC0v1_NODE then begin
               _prc_piLLcC0v1_setNext(_tmp_piLLcC0v1_POINTER, _fnc_piLLcC0v1_getNext(_cst_piLLcC0v1_NODE));
                // а если он был первым то фиксим указатель
                if _var_piLLcC0v1_FIRST=_cst_piLLcC0v1_NODE
                then _var_piLLcC0v1_FIRST:=_fnc_piLLcC0v1_getNext(_cst_piLLcC0v1_NODE);
            end;
        end
       else
        if _var_piLLcC0v1_FIRST=_cst_piLLcC0v1_NODE then begin
            // тоесть список из ОДНОГО элемента, и его надо вырезать
           _var_piLLcC0v1_FIRST:=NIL;
        end;
    end
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef Supre Local macros
    {$unDef _tmp_piLLcC0v1_POINTER}
    //--- undef Local macros
    {$unDef _var_piLLcC0v1_FIRST}
    {$unDef _cst_piLLcC0v1_NODE}
    {$unDef _fnc_piLLcC0v1_getNext}
    {$unDef _prc_piLLcC0v1_setNext}
    //--- undef user
    {$unDef _m_protoInkLLc_C0v1__tmp_POINTER}
    {$unDef _M_protoInkLLc_C0v1__var_FIRST}
    {$unDef _M_protoInkLLc_C0v1__cst_NODE}
    {$unDef _M_protoInkLLc_C0v1__lcl_getNext}
    {$unDef _M_protoInkLLc_C0v1__lcl_setNext}
{%endregion 'unDEF used macros' /fold}
