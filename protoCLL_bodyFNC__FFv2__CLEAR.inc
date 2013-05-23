{//.[ PROto Cyclic Linked Lists].....................[ in0k © 13.01.2013 ]...///
///                                                                          ///
///                                _____                                     ///
///                     +-+-+-+-+-|   __|_ _ first -> -                      ///
///                     |  PROto  |  |__| | |         -                      ///
///                     +-+-+-+-+-|_____|_|_|         -                      ///
///                          v 0.9           first <- =                      ///
///                                                                          ///
///..........................................................................//}
{%region /fold 'check "define" for all used macros'                      }
    //--- VARs
    {$if defined (_M_protoCLL_FFv2__var_FIRST)}
        {$define _var_protoCllFFv2_FIRST:=_M_protoCLL_FFv2__var_FIRST}
    {$else}
        {$FATAL 'macro ".._var_protoCllFFv2_FIRST" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoCLL_FFv2__lcl_getNext)}
        {$define _fnc_protoCllFFv2_getNext:=_M_protoCLL_FFv2__lcl_getNext}
    {$elseif defined (_M_protoCLL_blockFNK__getNext)}
        {$define _fnc_protoCllFFv2_getNext:=_M_protoCLL_blockFNK__getNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoCLL_FFv2__lcl_setNext)}
        {$define _fnc_protoCllFFv2_setNext:=_M_protoCLL_FFv2__lcl_setNext}
    {$elseif defined (_M_protoCLL_blockFNK__setNext)}
        {$define _fnc_protoCllFFv2_setNext:=_M_protoCLL_blockFNK__setNext}
    {$else}
        {$FATAL 'macro ".._setNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoCLL_FFv2__lcl_nodeDST)}
        {$define _fnc_protoCllFFv2_nodeDST:=_M_protoCLL_FFv2__lcl_nodeDST}
    {$elseif defined (_M_protoCLL_blockFNK__nodeDST)}
        {$define _fnc_protoCllFFv2_nodeDST:=_M_protoCLL_blockFNK__nodeDST}
    {$else}
        {$FATAL 'macro ".._fnc_protoCllFFv2_nodeDST" : NOT define!'}
    {$endif}
{%endregion}
{%region /fold 'setUP local VARs'                                        }
{$if defined (_m_protoCLL_FFv2__tmp_POINTER)}
    {$define _tmp_protoCllFFv2_POINTER:=_m_protoCLL_FFv2__tmp_POINTER}
{$else}
var tmp:pointer;
    {$define _tmp_protoCllFFv2_POINTER:=tmp}
{$endif}
{%endregion}
begin
    if _var_protoCllFFv2_FIRST<>nil then begin
        //--- рвем кольцо, _var_protoCllFFv2_FIRST станет ВТОРЫМ элементом
       _tmp_protoCllFFv2_POINTER:=_fnc_protoCllFFv2_getNext(_var_protoCllFFv2_FIRST);
       _fnc_protoCllFFv2_setNext(_var_protoCllFFv2_FIRST,NIL);
       _var_protoCllFFv2_FIRST  :=_tmp_protoCllFFv2_POINTER;
        //--- теперь как обычный список
        while _var_protoCllFFv2_FIRST<>nil do begin
            // шаг на СЛЕДУЮЩИЙ
           _tmp_protoCllFFv2_POINTER:=_var_protoCllFFv2_FIRST;
           _var_protoCllFFv2_FIRST  :=_fnc_protoCllFFv2_getNext(_tmp_protoCllFFv2_POINTER);
            // уничтожение элемента tmp
           _fnc_protoCllFFv2_nodeDST(_tmp_protoCllFFv2_POINTER);
        end;
    end;
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef SUPER local macros
    {$unDef _tmp_protoCllFFv2_POINTER}
    //--- undef Local macros
    {$unDef _var_protoCllFFv2_FIRST}
    {$unDef _fnc_protoCllFFv2_getNext}
    {$unDef _fnc_protoCllFFv2_setNext}
    {$unDef _fnc_protoCllFFv2_nodeDST}
    //--- undef user macros
    {$undef _m_protoCLL_FFv2__tmp_POINTER}
    {$undef _M_protoCLL_FFv2__var_FIRST}
    {$unDef _M_protoCLL_FFv2__lcl_getNext}
    {$unDef _M_protoCLL_FFv2__lcl_setNext}
    {$unDef _M_protoCLL_FFv2__lcl_nodeDST}
{%endregion}