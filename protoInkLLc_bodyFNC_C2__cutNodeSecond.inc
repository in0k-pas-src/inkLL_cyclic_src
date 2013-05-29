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
    {$if defined (_M_protoInkLLc_C2__cst_FIRST)}
        {$define _cst_piLLcC2_FIRST:=_M_protoInkLLc_C2__cst_FIRST}
    {$else}
        {$FATAL 'macro ".._cst_FIRST" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_C2__out_NODE)}
        {$define _out_piLLcC2_NODE:=_M_protoInkLLc_C2__out_NODE}
    {$else}
        {$FATAL 'macro ".._out_NODE" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoInkLLc_C2__lcl_getNext)}
        {$define _fnc_piLLcC2_getNext:=_M_protoInkLLc_C2__lcl_getNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__GetNext)}
        {$define _fnc_piLLcC2_getNext:=_M_protoInkLLc_blockFNK__GetNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_C2__lcl_setNext)}
        {$define _fnc_piLLcC2_setNext:=_M_protoInkLLc_C2__lcl_setNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__SetNext)}
        {$define _fnc_piLLcC2_setNext:=_M_protoInkLLc_blockFNK__SetNext}
    {$else}
        {$FATAL 'macro ".._setNext" : NOT define!'}
    {$endif}
{%endregion}
begin
    {$ifOpt D+}
        if _cst_piLLcC2_FIRST=nil then begin
           raise Exception.CReate('protoCLL_bodyFNC__C2__cutNodeSecond _cst_piLLcC2_FIRST==nil !!!');
        end
       else
       if _cst_piLLcC2_FIRST=_fnc_piLLcC2_getNext(_cst_piLLcC2_FIRST) then begin
          raise Exception.CReate('protoCLL_bodyFNC__C2__cutNodeSecond List IS ONE node, secondNode==NIL !!!');
       end;
    {$endif}
   _out_piLLcC2_NODE:=_fnc_piLLcC2_getNext(_cst_piLLcC2_FIRST);
   _fnc_piLLcC2_setNext(_cst_piLLcC2_FIRST, _fnc_piLLcC2_getNext(_out_piLLcC2_NODE))
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef SupreLocal macros
    {$unDef _cst_piLLcC2_FIRST}
    {$unDef _out_piLLcC2_NODE}
    {$unDef _fnc_piLLcC2_getNext}
    {$unDef _fnc_piLLcC2_setNext}
    //--- undef user
    {$unDef _M_protoInkLLc_C2__cst_FIRST}
    {$unDef _M_protoInkLLc_C2__out_NODE}
    {$unDef _M_protoInkLLc_C2__lcl_getNext}
    {$unDef _M_protoInkLLc_C2__lcl_setNext}
{%endregion}
