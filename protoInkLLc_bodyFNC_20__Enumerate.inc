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
    {$if defined (_M_protoInkLLc_20__cst_FIRST)}
        {$define _cst_piLLc20_FIRST:=_M_protoInkLLc_20__cst_FIRST}
    {$else}
        {$FATAL 'macro ".._FIRST" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_20__cst_enumFNC)}
        {$define _cst_piLLc20_enumFNC:=_M_protoInkLLc_20__cst_enumFNC}
    {$else}
        {$FATAL 'macro ".._enumFNC" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_20__cst_context)}
        {$define _cst_piLLc20_context:=_M_protoInkLLc_20__cst_context}
    {$else}
        {$define _cst_piLLc20_context:=NIL}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_20__out_LAST)}
        {$define _out_piLLc20_LAST:=_M_protoInkLLc_20__out_LAST}
    {$else}
        {$FATAL 'macro ".._out_piLLc20_LAST" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoInkLLc_20__lcl_getNext)}
        {$define _fnc_piLLc20_getNext:=_M_protoInkLLc_20__lcl_getNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__GetNext)}
        {$define _fnc_piLLc20_getNext:=_M_protoInkLLc_blockFNK__GetNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
{%endregion 'check "define" for all used macros' /fold}
begin
   _out_piLLc20_LAST:=_cst_piLLc20_FIRST;
    if _out_piLLc20_LAST<>nil then begin
        repeat
            {$if defined(_M_protoInkLLc_20__lcl_preENUM)}
              {$define _fnc_piLLc20_enumOBJ:=_M_protoInkLLc_20__lcl_preENUM(_out_piLLc20_LAST)}
            {$else}
              {$define _fnc_piLLc20_enumOBJ:=_out_piLLc20_LAST}
            {$endif}
            if _cst_piLLc20_enumFNC(_cst_piLLc20_context,_fnc_piLLc20_enumOBJ)
            then _out_piLLc20_LAST:=_fnc_piLLc20_getNext(_out_piLLc20_LAST)
            else begin
              {$if defined(_M_protoInkLLc_20__lcl_preENUM)}
               _out_piLLc20_LAST:=_fnc_piLLc20_enumOBJ;
              {$endif}
                break;
            end;
            //--
            if _out_piLLc20_LAST=_cst_piLLc20_FIRST then _out_piLLc20_LAST:=NIL;
        until _out_piLLc20_LAST=nil;
    end;
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef Local macros
    {$unDef _cst_piLLc20_FIRST}
    {$unDef _cst_piLLc20_enumFNC}
    {$unDef _cst_piLLc20_context}
    {$unDef _out_piLLc20_LAST}
    {$unDef _fnc_piLLc20_getNext}
    //--- undef user
    {$unDef _M_protoInkLLc_20__cst_FIRST}
    {$unDef _M_protoInkLLc_20__lcl_preENUM}
    {$unDef _M_protoInkLLc_20__cst_enumFNC}
    {$unDef _M_protoInkLLc_20__cst_context}
    {$unDef _M_protoInkLLc_20__out_LAST}
    {$unDef _M_protoInkLLc_20__lcl_getNext}
{%endregion 'unDEF used macros' /fold}

