{//.[ PROto Cyclic Linked Lists].....................[ in0k © 13.01.2013 ]...///
///                                                                          ///
///                                _____                                     ///
///                     +-+-+-+-+-|   __|_ _ first -> -                      ///
///                     |  PROto  |  |__| | |         -                      ///
///                     +-+-+-+-+-|_____|_|_|         -                      ///
///                          v 2.0           first <- =                      ///
///                                                                          ///
///............................................[ v 2.0 in0k © 05.06.2013 ]...//}
{%region /fold 'check "define" for all used macros'                      }
    //--- VARs
    {$if defined (_M_protoInkLLc_E4__var_FIRST)}
        {$define _var_piLLcE4_FIRST:=_M_protoInkLLc_E4__var_FIRST}
    {$else}
        {$FATAL 'macro ".._FIRST" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_E4__cst_cmpCTX)}
        {$define _cst_piLLcE4_cmpCXT:=_M_protoInkLLc_E4__cst_cmpCTX}
    {$else}
        {$FATAL 'macro ".._cmpCTX" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_E4__lcl_cmpFNC)}
        {$define _fnc_piLLcE4_cmpFNC:=_M_protoInkLLc_E4__lcl_cmpFNC}
    {$else}
        {$FATAL 'macro ".._cmpFNC" : NOT define!'}
    {$endif}
    //--- FNCs
    {$if defined (_M_protoInkLLc_E4__lcl_getNext)}
        {$define _fnc_piLLcE4_getNext:=_M_protoInkLLc_E4__lcl_getNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__GetNext)}
        {$define _fnc_piLLcE4_getNext:=_M_protoInkLLc_blockFNK__GetNext}
    {$else}
        {$FATAL 'macro ".._GetNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_E4__lcl_setNext)}
        {$define _prc_piLLcE4_setNext:=_M_protoInkLLc_E4__lcl_setNext}
    {$elseif defined (_M_protoInkLLc_blockFNK__SetNext)}
        {$define _prc_piLLcE4_setNext:=_M_protoInkLLc_blockFNK__SetNext}
    {$else}
        {$FATAL 'macro ".._SetNext" : NOT define!'}
    {$endif}
    //---
    {$if defined (_M_protoInkLLc_E4__lcl_dspPRC)}
        {$define _prc_piLLcE4_dspPRC:=_M_protoInkLLc_E4__lcl_dspPRC}
    {$else}
        {$FATAL 'macro ".._dspPRC" : NOT define!'}
    {$endif}
{%endregion}
{%region /fold 'setUP local VARs'                                        }
{$if defined (_m_protoInkLLc_E4__tmp_POINTER0)}
    {$define _tmp_piLLcE4_POINTER0:=_m_protoInkLLc_E4__tmp_POINTER0}
{$else}
var tmp:pointer;
    {$define _tmp_piLLcE4_POINTER0:=tmp}
{$endif}
{$if defined (_m_protoInkLLc_E4__tmp_POINTER1)}
    {$define _tmp_piLLcE4_POINTER1:=_m_protoInkLLc_E4__tmp_POINTER1}
{$else}
var tmq:pointer;
    {$define _tmp_piLLcE4_POINTER1:=tmq}
{$endif}
{%endregion}
begin
    //--- работа с ПОСЛЕДУЮЩИМИ
    if _var_piLLcE4_FIRST<>nil then begin
       _tmp_piLLcE4_POINTER0:=_var_piLLcE4_FIRST;
       _tmp_piLLcE4_POINTER1:=_fnc_piLLcE4_getNext(_tmp_piLLcE4_POINTER0);
        while _tmp_piLLcE4_POINTER1<>_var_piLLcE4_FIRST do begin
            if _fnc_piLLcE4_cmpFNC(_M_protoInkLLc_E4__cst_cmpCTX,_tmp_piLLcE4_POINTER1) then begin
               _prc_piLLcE4_setNext(_tmp_piLLcE4_POINTER0,_fnc_piLLcE4_getNext(_tmp_piLLcE4_POINTER1));
               _prc_piLLcE4_dspPRC (_tmp_piLLcE4_POINTER1);
               _tmp_piLLcE4_POINTER1:=_fnc_piLLcE4_getNext(_tmp_piLLcE4_POINTER0);
            end
            else begin
              _tmp_piLLcE4_POINTER0:=_tmp_piLLcE4_POINTER1;
              _tmp_piLLcE4_POINTER1:=_fnc_piLLcE4_getNext(_tmp_piLLcE4_POINTER0);
            end
        end;
        //---
        if _fnc_piLLcE4_cmpFNC(_M_protoInkLLc_E4__cst_cmpCTX,_var_piLLcE4_FIRST) then begin
            if _tmp_piLLcE4_POINTER0=_var_piLLcE4_FIRST then begin
               _var_piLLcE4_FIRST:=NIL;
            end
            else begin
               _prc_piLLcE4_setNext(_tmp_piLLcE4_POINTER0,_fnc_piLLcE4_getNext(_var_piLLcE4_FIRST));
               _var_piLLcE4_FIRST:=_tmp_piLLcE4_POINTER0;
            end;
           _prc_piLLcE4_dspPRC (_tmp_piLLcE4_POINTER1);
        end;
    end;
end;
{%region /fold 'unDEF used macros'                                       }
    //--- undef SUPER local macros
    {$unDef _tmp_piLLcE4_POINTER0}
    {$unDef _tmp_piLLcE4_POINTER1}
    //--- undef Local macros
    {$unDef _var_piLLcE4_FIRST}
    {$unDef _cst_piLLcE4_cmpCXT}
    {$unDef _fnc_piLLcE4_cmpFNC}
    {$unDef _prc_piLLcE4_dspPRC}
    {$unDef _fnc_piLLcE4_getNext}
    {$unDef _prc_piLLcE4_setNext}
    //--- undef user macros
    {$undef _m_protoInkLLc_E4__tmp_POINTER0}
    {$undef _m_protoInkLLc_E4__tmp_POINTER1}
    {$undef _M_protoInkLLc_E4__var_FIRST}
    {$unDef _M_protoInkLLc_E4__cst_cmpCTX}
    {$unDef _M_protoInkLLc_E4__lcl_cmpFNC}
    {$unDef _M_protoInkLLc_E4__lcl_dspPRC}
    {$unDef _M_protoInkLLc_E4__lcl_getNext}
    {$unDef _M_protoInkLLc_E4__lcl_setNext}
{%endregion}
