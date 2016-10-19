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
    {$if defined (_M_protoInkLLc_FFv2__var_FIRST)}
        {$define _var_piLLcFFv2_FIRST:=_M_protoInkLLc_FFv2__var_FIRST}
    {$else}
        {$FATAL 'macro ".._FIRST" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoInkLLc_FFv2__lcl_getNext)}
        {$define _fnc_piLLcFFv2_getNext:=_M_protoInkLLc_FFv2__lcl_getNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__GetNext)}
        {$define _fnc_piLLcFFv2_getNext:=_M_protoInkLLc_blockFNK__GetNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_FFv2__lcl_setNext)}
        {$define _prc_piLLcFFv2_setNext:=_M_protoInkLLc_FFv2__lcl_setNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__SetNext)}
        {$define _prc_piLLcFFv2_setNext:=_M_protoInkLLc_blockFNK__SetNext}
    {$else}
        {$FATAL 'macro ".._setNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_FFv2__lcl_nodeDST)}
        {$define _fnc_piLLcFFv2_nodeDST:=_M_protoInkLLc_FFv2__lcl_nodeDST}
    {$elseif defined (_M_protoInkLLc_blockFNK__NodeDST)}
        {$define _fnc_piLLcFFv2_nodeDST:=_M_protoInkLLc_blockFNK__NodeDST}
    {$else}
        {$FATAL 'macro ".._fnc_piLLcFFv2_nodeDST" : NOT define!'}
    {$endif}
{%endregion}
{%region /fold 'setUP local VARs'                                        }
{$if defined (_m_protoInkLLc_FFv2__tmp_POINTER)}
    {$define _tmp__piLLcFFv2_POINTER:=_m_protoInkLLc_FFv2__tmp_POINTER}
{$else}
var tmp:pointer;
    {$define _tmp__piLLcFFv2_POINTER:=tmp}
{$endif}
{%endregion}
begin
    if _var_piLLcFFv2_FIRST<>nil then begin
        //--- рвем кольцо, _var_piLLcFFv2_FIRST станет ВТОРЫМ элементом
       _tmp__piLLcFFv2_POINTER:=_fnc_piLLcFFv2_getNext(_var_piLLcFFv2_FIRST);
       _prc_piLLcFFv2_setNext(_var_piLLcFFv2_FIRST,NIL);
       _var_piLLcFFv2_FIRST  :=_tmp__piLLcFFv2_POINTER;
        //--- теперь как обычный список
        while _var_piLLcFFv2_FIRST<>nil do begin
            // шаг на СЛЕДУЮЩИЙ
           _tmp__piLLcFFv2_POINTER:=_var_piLLcFFv2_FIRST;
           _var_piLLcFFv2_FIRST  :=_fnc_piLLcFFv2_getNext(_tmp__piLLcFFv2_POINTER);
            // уничтожение элемента tmp
           _fnc_piLLcFFv2_nodeDST(_tmp__piLLcFFv2_POINTER);
        end;
    end;
    {todo: а че не так?}
    (*// рвем кольцо
    tmp:=List^.next;
    List^.next:=NIL;
    // уничтожаем список
    repeat
        List:=tmp^.next;
       _EVENT_NODE__DST_(tmp);
        tmp :=List;
    until not Assigned(tmp);*)
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef SUPER local macros
    {$unDef _tmp__piLLcFFv2_POINTER}
    //--- undef Local macros
    {$unDef _var_piLLcFFv2_FIRST}
    {$unDef _fnc_piLLcFFv2_getNext}
    {$unDef _prc_piLLcFFv2_setNext}
    {$unDef _fnc_piLLcFFv2_nodeDST}
    //--- undef user macros
    {$undef _m_protoInkLLc_FFv2__tmp_POINTER}
    {$undef _M_protoInkLLc_FFv2__var_FIRST}
    {$unDef _M_protoInkLLc_FFv2__lcl_getNext}
    {$unDef _M_protoInkLLc_FFv2__lcl_setNext}
    {$unDef _M_protoInkLLc_FFv2__lcl_nodeDST}
{%endregion}
