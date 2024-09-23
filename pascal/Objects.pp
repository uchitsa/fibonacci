(*
 * The MIT License (MIT)
 *
 * Copyright (c) 2022-2024 Yegor Bugayenko
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *)

program Objects;

{$mode objfpc}

uses
    SysUtils;

type
    TBool = interface
        function Get:Boolean;
    end;

    TInt = interface
        function Get:Int32;
    end;

    TInteger = class(TInterfacedObject, TInt)
        private
            value:Int32;

        public
            constructor Create(v:Int32); overload;
            function Get:Int32;
    end;

    TLess = class(TInterfacedObject, TBool)
        private
            left:TInt;
            right:TInt;

        public
            constructor Create(l:TInt; r:TInt); overload;
            function Get:Boolean;
    end;

    TSub = class(TInterfacedObject, TInt)
        private
            left:TInt;
            right:TInt;

        public
            constructor Create(l:TInt; r:TInt); overload;
            function Get:Int32;
    end;

    TAdd = class(TInterfacedObject, TInt)
        private
            left:TInt;
            right:TInt;

        public
            constructor Create(l:TInt; r:TInt); overload;
            function Get:Int32;
    end;

    TIf = class(TInterfacedObject, TInt)
        private
            term:TBool;
            left:TInt;
            right:TInt;

        public
            constructor Create(t:TBool; l:TInt; r:TInt); overload;
            function Get:Int32;
    end;

    TFibo = class(TInterfacedObject, TInt)
        private
            value:TInt;

        public
            constructor Create(v:TInt); overload;
            function Get:Int32;
    end;

{TInteger class}
    constructor TInteger.Create(v:Int32); overload;
    begin
        value := v;
    end;

    function TInteger.Get:Int32;
    begin
      Result := value;
    end;

{TLess class}
    constructor TLess.Create(l:TInt; r:TInt); overload;
    begin
        left := l;
        right := r;
    end;

    function TLess.Get:Boolean;
    begin
        Result := left.Get() < right.Get();
    end;

{TSub class}
    constructor TSub.Create(l:TInt; r:TInt); overload;
    begin
        left := l;
        right := r;
    end;

    function TSub.Get:Int32;
    begin
        Result := left.Get() - right.Get();
    end;

{TAdd class}
    constructor TAdd.Create(l:TInt; r:TInt); overload;
    begin
        left := l;
        right := r;
    end;

    function TAdd.Get:Int32;
    begin
        Result := left.Get() + right.Get();
    end;

{TIf class}
    constructor TIf.Create(t:TBool; l:TInt; r:TInt); overload;
    begin
        term := t;
        left := l;
        right := r;
    end;

    function TIf.Get:Int32;
    begin
        if term.Get() then
            Result := left.Get()
        else
            Result := right.Get();
    end;

{TFibo class}
    constructor TFibo.Create(v:TInt); overload;
    begin
        value := v;
    end;

    function TFibo.Get:Int32;
    begin
        Result := TIf.Create(
            TLess.Create(value, TInteger.Create(2)),
                TInteger.Create(1),
                TAdd.Create(
                    TFibo.Create(TSub.Create(value, TInteger.Create(1))),
                    TFibo.Create(TSub.Create(value, TInteger.Create(2))
                )
            )
        ).Get();
    end;

var
    total:Int32;
    f:Int32;
    input:TInteger;
    cycles:Int32;
    i:Int32;

begin
    total := 0;
    f := 0;

    if ParamCount <> 2 then
    begin
      WriteLn('Two args required: INPUT and CYCLES');
      exit;
    end;

    input := TInteger.Create(StrToInt(ParamStr(1)));
    cycles := StrToInt(ParamStr(2));

    for i := 1 to cycles do
    begin
        f := TFibo.Create(input).Get();
        total := total + f;
    end;

    WriteLn(IntToStr(input.Get()) + '-th Fibonacci number is ' + IntToStr(f));
    WriteLn('Total is ' + IntToStr(total));
end.

