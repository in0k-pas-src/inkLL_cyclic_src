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
    {$if defined (_M_protoCLL_11__cst_FIRST)}
        {$define _cst_protoCll11_FIRST:=_M_protoCLL_11__cst_FIRST}
    {$else}
        {$FATAL 'macro ".._cst_protoCll11_FIRST" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoCLL_11__out_COUNT)}
        {$define _out_protoCll11_COUNT:=_M_protoCLL_11__out_COUNT}
    {$else}
        {$FATAL 'macro ".._out_protoCll11_COUNT" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoCLL_11__lcl_getNext)}
        {$define _fnc_protoCll11_getNext:=_M_protoCLL_11__lcl_getNext}
    {$elseif defined (_M_protoCLL_blockFNK__getNext)}
        {$define _fnc_protoCll11_getNext:=_M_protoCLL_blockFNK__getNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
{%endregion}
{%region /fold 'setUP local VARs'                                        }
{$if defined (_m_protoCLL_11__tmp_POINTER)}
    {$define _tmp_protoCll11_POINTER:=_m_protoCLL_11__tmp_POINTER}
{$else}
var tmp:pointer;
    {$define _tmp_protoCll11_POINTER:=tmp}
{$endif}
{%endregion}
begin
    if _cst_protoCll11_FIRST<>nil then begin
       _out_protoCll11_COUNT:=1;
       _tmp_protoCll11_POINTER:=_fnc_protoCll11_getNext(_cst_protoCll11_FIRST);
        while _tmp_protoCll11_POINTER<>_cst_protoCll11_FIRST do begin
            inc(_out_protoCll11_COUNT);
           _tmp_protoCll11_POINTER:=_fnc_protoCll11_getNext(_tmp_protoCll11_POINTER);
        end
    end
    else _out_protoCll11_COUNT:=0;
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef SUPER local macros
    {$unDef _tmp_protoCll11_POINTER}
    //--- undef Local macros
    {$unDef _cst_protoCll11_FIRST}
    {$unDef _out_protoCll11_COUNT}
    {$unDef _fnc_protoCll11_getNext}
    //--- undef user macros
    {$undef _m_protoCLL_11__tmp_POINTER}
    {$undef _M_protoCLL_11__cst_FIRST}
    {$undef _M_protoCLL_11__out_COUNT}
    {$unDef _M_protoCLL_11__lcl_getNext}
{%endregion}
