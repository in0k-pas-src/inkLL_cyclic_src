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
    {$if defined (_M_protoCLL_C2__cst_FIRST)}
        {$define _cst_protoCllC2_FIRST:=_M_protoCLL_C2__cst_FIRST}
    {$else}
        {$FATAL 'macro ".._cst_FIRST" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoCLL_C2__out_NODE)}
        {$define _out_protoCllC2_NODE:=_M_protoCLL_C2__out_NODE}
    {$else}
        {$FATAL 'macro ".._out_NODE" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoCLL_C2__lcl_getNext)}
        {$define _fnc_protoCllC2_getNext:=_M_protoCLL_C2__lcl_getNext}
    {$elseif defined (_M_protoCLL_blockFNK__getNext)}
        {$define _fnc_protoCllC2_getNext:=_M_protoCLL_blockFNK__getNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoCLL_C2__lcl_setNext)}
        {$define _fnc_protoCllC2_setNext:=_M_protoCLL_C2__lcl_setNext}
    {$elseif defined (_M_protoCLL_blockFNK__setNext)}
        {$define _fnc_protoCllC2_setNext:=_M_protoCLL_blockFNK__setNext}
    {$else}
        {$FATAL 'macro ".._setNext" : NOT define!'}
    {$endif}
{%endregion}
begin
    {$ifOpt D+}
        if _cst_protoCllC2_FIRST=nil then begin
           raise Exception.CReate('protoCLL_bodyFNC__C2__cutNodeSecond _cst_protoCllC2_FIRST==nil !!!');
        end
       else
       if _cst_protoCllC2_FIRST=_fnc_protoCllC2_getNext(_cst_protoCllC2_FIRST) then begin
          raise Exception.CReate('protoCLL_bodyFNC__C2__cutNodeSecond List IS ONE node, secondNode==NIL !!!');
       end;
    {$endif}
   _out_protoCllC2_NODE:=_fnc_protoCllC2_getNext(_cst_protoCllC2_FIRST);
   _fnc_protoCllC2_setNext(_cst_protoCllC2_FIRST, _fnc_protoCllC2_getNext(_out_protoCllC2_NODE))
end;
{%region 'unDEF used macros' /fold}
    //--- undef SupreLocal macros
    {$unDef _cst_protoCllC2_FIRST}
    {$unDef _out_protoCllC2_NODE}
    {$unDef _fnc_protoCllC2_getNext}
    {$unDef _fnc_protoCllC2_setNext}
    //--- undef user
    {$unDef _M_protoCLL_C2__cst_FIRST}
    {$unDef _M_protoCLL_C2__out_NODE}
    {$unDef _M_protoCLL_C2__lcl_getNext}
    {$unDef _M_protoCLL_C2__lcl_setNext}
{%endregion}
