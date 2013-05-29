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
    {$if defined (_M_protoInkLLc_11__cst_FIRST)}
        {$define _cst_piLLc11_FIRST:=_M_protoInkLLc_11__cst_FIRST}
    {$else}
        {$FATAL 'macro ".._FIRST" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_11__out_COUNT)}
        {$define _out_piLLc11_COUNT:=_M_protoInkLLc_11__out_COUNT}
    {$else}
        {$FATAL 'macro ".._COUNT" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoInkLLc_11__lcl_getNext)}
        {$define _fnc_piLLc11_getNext:=_M_protoInkLLc_11__lcl_getNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__GetNext)}
        {$define _fnc_piLLc11_getNext:=_M_protoInkLLc_blockFNK__GetNext}
    {$else}
        {$FATAL 'macro ".._getNext" : NOT define!'}
    {$endif}
{%endregion}
{%region /fold 'setUP local VARs'                                        }
{$if defined (_m_protoInkLLc_11__tmp_POINTER)}
    {$define _tmp_piLLc11_POINTER:=_m_protoInkLLc_11__tmp_POINTER}
{$else}
var tmp:pointer;
    {$define _tmp_piLLc11_POINTER:=tmp}
{$endif}
{%endregion}
begin
    if _cst_piLLc11_FIRST<>nil then begin
       _out_piLLc11_COUNT:=1;
       _tmp_piLLc11_POINTER:=_fnc_piLLc11_getNext(_cst_piLLc11_FIRST);
        while _tmp_piLLc11_POINTER<>_cst_piLLc11_FIRST do begin
            inc(_out_piLLc11_COUNT);
           _tmp_piLLc11_POINTER:=_fnc_piLLc11_getNext(_tmp_piLLc11_POINTER);
        end
    end
    else _out_piLLc11_COUNT:=0;
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef SUPER local macros
    {$unDef _tmp_piLLc11_POINTER}
    //--- undef Local macros
    {$unDef _cst_piLLc11_FIRST}
    {$unDef _out_piLLc11_COUNT}
    {$unDef _fnc_piLLc11_getNext}
    //--- undef user macros
    {$undef _m_protoInkLLc_11__tmp_POINTER}
    {$undef _M_protoInkLLc_11__cst_FIRST}
    {$undef _M_protoInkLLc_11__out_COUNT}
    {$unDef _M_protoInkLLc_11__lcl_getNext}
{%endregion}
