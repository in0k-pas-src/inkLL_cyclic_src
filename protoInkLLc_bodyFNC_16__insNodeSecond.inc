{//.[ PROto Cyclic Linked Lists].....................[ in0k © 13.01.2013 ]...///
///                                                                          ///
///                                _____                                     ///
///                     +-+-+-+-+-|   __|_ _ first -> -                      ///
///                     |  PROto  |  |__| | |         -                      ///
///                     +-+-+-+-+-|_____|_|_|         -                      ///
///                          v 2.0           first <- =                      ///
///                                                                          ///
///............................................[ v 2.0 in0k © 28.05.2013 ]...//}
///  если список пуст, то добавляем ПЕРВЫМ элементом
///-----------------------------------------------------------------------------
{%region /fold 'check "define" for all used macros'                      }
    //--- VARs
    {$if defined (_M_protoInkLLc_16__var_FIRST)}
        {$define _var_piLLc16_FIRST:=_M_protoInkLLc_16__var_FIRST}
    {$else}
        {$FATAL 'macro ".._cst_FIRST" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_16__cst_NODE)}
        {$define _cst_piLLc16_NODE:=_M_protoInkLLc_16__cst_NODE}
    {$else}
        {$FATAL 'macro ".._out_NODE" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoInkLLc_16__lcl_getNext)}
        {$define _fnc_piLLc16_getNext:=_M_protoInkLLc_16__lcl_getNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__GetNext)}
        {$define _fnc_piLLc16_getNext:=_M_protoInkLLc_blockFNK__GetNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_16__lcl_setNext)}
        {$define _fnc_piLLc16_setNext:=_M_protoInkLLc_16__lcl_setNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__SetNext)}
        {$define _fnc_piLLc16_setNext:=_M_protoInkLLc_blockFNK__SetNext}
    {$else}
        {$FATAL 'macro ".._setNext" : NOT define!'}
    {$endif}
{%endregion}
begin {todo: поменять очередность, имходя из того что чаще тут что-то лежит}
    if _var_piLLc16_FIRST=nil then begin
       _var_piLLc16_FIRST:=_M_protoInkLLc_16__cst_NODE;
       _fnc_piLLc16_setNext(_var_piLLc16_FIRST,_var_piLLc16_FIRST);
    end
    else begin
       _fnc_piLLc16_setNext(_cst_piLLc16_NODE ,_fnc_piLLc16_getNext(_var_piLLc16_FIRST));
       _fnc_piLLc16_setNext(_var_piLLc16_FIRST,_cst_piLLc16_NODE);
    end;
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef SupreLocal macros
    {$unDef _var_piLLc16_FIRST}
    {$unDef _cst_piLLc16_NODE}
    {$unDef _fnc_piLLc16_getNext}
    {$unDef _fnc_piLLc16_setNext}
    //--- undef user
    {$unDef _M_protoInkLLc_16__var_FIRST}
    {$unDef _M_protoInkLLc_16__cst_NODE}
    {$unDef _M_protoInkLLc_16__lcl_getNext}
    {$unDef _M_protoInkLLc_16__lcl_setNext}
{%endregion}
