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
    {$if defined (_M_protoCLL_20__cst_FIRST)}
        {$define _cst_protoCll20_FIRST:=_M_protoCLL_20__cst_FIRST}
    {$else}
        {$FATAL 'macro ".._cst_protoCll20_FIRST" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoCLL_20__cst_enumFNC)}
        {$define _cst_protoCll20_enumFNC:=_M_protoCLL_20__cst_enumFNC}
    {$else}
        {$FATAL 'macro ".._cst_protoCll20_enumFNC" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoCLL_20__cst_enumDATA)}
        {$define _cst_protoCll20_enumDATA:=_M_protoCLL_20__cst_enumDATA}
    {$else}
        {$define _cst_protoCll20_enumDATA:=NIL}
    {$endif}
    //---
    {$if defined (_M_protoCLL_20__out_LAST)}
        {$define _out_protoCll20_LAST:=_M_protoCLL_20__out_LAST}
    {$else}
        {$FATAL 'macro ".._out_protoCll20_LAST" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoCLL_20__lcl_getNext)}
        {$define _fnc_protoCll20_getNext:=_M_protoCLL_20__lcl_getNext}
    {$elseif defined (_M_protoCLL_blockFNK__getNext)}
        {$define _fnc_protoCll20_getNext:=_M_protoCLL_blockFNK__getNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
{%endregion 'check "define" for all used macros' /fold}
begin
   _out_protoCll20_LAST:=_cst_protoCll20_FIRST;
    if _out_protoCll20_LAST<>nil then begin
        repeat
          if _cst_protoCll20_enumFNC(_cst_protoCll20_enumData,_out_protoCll20_LAST)
          then _out_protoCll20_LAST:=_fnc_protoCll20_getNext(_out_protoCll20_LAST)
          else  break;
          //--
          if _out_protoCll20_LAST=_cst_protoCll20_FIRST then _out_protoCll20_LAST:=NIL;
        until _out_protoCll20_LAST=nil;
    end;
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef Local macros
    {$unDef _cst_protoCll20_FIRST}
    {$unDef _cst_protoCll20_enumFNC}
    {$unDef _cst_protoCll20_enumDATA}
    {$unDef _out_protoCll20_LAST}
    {$unDef _fnc_protoCll20_getNext}
    //--- undef user
    {$unDef _M_protoCLL_20__cst_FIRST}
    {$unDef _M_protoCLL_20__cst_enumFNC}
    {$unDef _M_protoCLL_20__cst_enumDATA}
    {$unDef _M_protoCLL_20__out_LAST}
    {$unDef _M_protoCLL_20__lcl_getNext}
{%endregion 'unDEF used macros' /fold}

