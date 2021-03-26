unit ReportObj;

interface

uses
  Classes, ADODB, ReportFormUnit, PDF417Barcode, DelphiZXingQRCode;

type
TReport = class(TInterfacedObject, IDispatch)
  private
    RForm:TReportForm;
    FProp: String;
    PDF417Column: integer;
    PDF417Row: integer;
  protected
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create(RepForm:TReportForm);
  end;

implementation
uses
  ActiveX, Windows, SysUtils, StrUtils, FR_Class, FR_view, Graphics, EncdDecd;

{ TReport }

constructor TReport.Create(RepForm: TReportForm);
begin
  RForm:=RepForm;
  PDF417Column := 16;
  PDF417Row := 32;
end;

function TReport.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
  LocaleID: Integer; DispIDs: Pointer): HResult;
type
  TDispIDsArray = array[0..0] of TDISPID;
  PDispIDsArray = ^TDispIDsArray;
var
  IDs: PDispIDsArray absolute DispIDs;
  i: integer;
  Name: WideString;
begin
  if NameCount > 1 then Result := DISP_E_UNKNOWNNAME
  else
    if NameCount < 1 then Result := E_INVALIDARG
    else Result := S_OK;
  for i := 0 to NameCount - 1 do
    IDs[i] := DISPID_UNKNOWN;
  if NameCount = 1 then
    begin
      Name := PWideChar(Names^);
      FProp := Name;
      IDs[0] := 1;
      if UpperCase(Name) = 'SHOWREPORT' then IDs[0] := 2;
      if UpperCase(Name) = 'PDF417CODE' then IDs[0] := 3;
      if UpperCase(Name) = 'PDF417PARAM' then IDs[0] := 4;
      if UpperCase(Name) = 'QRCODE' then IDs[0] := 5;
      if UpperCase(Name) = 'IMAGE' then IDs[0] := 6;
    end;
end;

function TReport.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TReport.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK;
end;

const
  VARIANT_ALPHABOOL = 2;
  VARIANT_LOCALBOOL = 16;

function TReport.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  P: TDISPPARAMS absolute Params;
  V,V1: OleVariant;
  repobj:TfrView;
  PDF417BarcodeVCL1: TPDF417BarcodeVCL;
  QRCodeBitmap:TBitmap;
  QRCode: TDelphiZXingQRCode;
  QRText:string;
  Row,Column:integer;
  Ms:TMemoryStream;
  SS:TStringStream;
begin
  if (DispID = 1) and (Flags and DISPATCH_PROPERTYPUT<>0) then
    begin
      Result := VariantChangeType(V, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
      if Result <> S_OK then exit;
      //FLines.Text:=AnsiReplaceStr(FLines.Text,'['+FProp+']',String(V));
      repobj:=RForm.frReport.FindObject(FProp);
     if repobj<>nil then
     begin
       repobj.Memo.Text:=String(V);
     end;
      Result := S_OK;
    end
  else
  if (DispID = 2) then
  begin
   RForm.frReport.PrepareReport;
   RForm.frReport.InitialZoom := pzPageWidth;
   RForm.frReport.ShowPreparedReport;
  end else
  if (DispID = 3) then
  begin
    Result := VariantChangeType(V1, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
    if Result <> S_OK then exit;
    Result := VariantChangeType(V, OleVariant(P.rgvarg[1]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
    if Result <> S_OK then exit;
    repobj:=RForm.frReport.FindObject(String(V));
    PDF417BarcodeVCL1:=TPDF417BarcodeVCL.Create(nil);
    PDF417BarcodeVCL1.Lines.Text := String(V1);
    PDF417BarcodeVCL1.DotSize := 1;
    PDF417BarcodeVCL1.LineHeight := 1;
    PDF417BarcodeVCL1.FixedColumn := PDF417Column;
    PDF417BarcodeVCL1.FixedRow:= PDF417Row;
    PDF417BarcodeVCL1.Options := PDF417BarcodeVCL1.Options + [poAutoErrorLevel] + [poFixedRow]+ [poFixedColumn];
    TfrPictureView(repobj).Picture.Assign(PDF417BarcodeVCL1.Bitmap);
    PDF417BarcodeVCL1.Free;
  end else
  if (DispID = 4) then
  begin
    Result := VariantChangeType(V1, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_I4);
    if Result <> S_OK then exit;
    Result := VariantChangeType(V, OleVariant(P.rgvarg[1]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_I4);
    if Result <> S_OK then exit;
    PDF417Column := Integer(V1);
    PDF417Row := Integer(V);
  end else
  if (DispID = 5) then
  begin
    Result := VariantChangeType(V1, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
    if Result <> S_OK then exit;
    Result := VariantChangeType(V, OleVariant(P.rgvarg[1]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
    if Result <> S_OK then exit;
    repobj:=RForm.frReport.FindObject(String(V));
    QRCodeBitmap := TBitmap.Create;
    QRCode := TDelphiZXingQRCode.Create;
    QRText := String(V1);
    QRCode.Data := QRText;
    QRCode.Encoding := TQRCodeEncoding(0);
    QRCode.QuietZone := StrToIntDef(QRText, 4);
    QRCodeBitmap.SetSize(QRCode.Rows, QRCode.Columns);
    for Row := 0 to QRCode.Rows - 1 do
      begin
        for Column := 0 to QRCode.Columns - 1 do
        begin
          if (QRCode.IsBlack[Row, Column]) then
          begin
            QRCodeBitmap.Canvas.Pixels[Column, Row] := clBlack;
          end else
          begin
            QRCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;
          end;
        end;
      end;
    TfrPictureView(repobj).Picture.Assign(QRCodeBitmap);
    QRCode.Free;
    QRCodeBitmap.Free;
  end else
  if (DispID = 6) then
  begin
    Result := VariantChangeType(V1, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
    if Result <> S_OK then exit;
    Result := VariantChangeType(V, OleVariant(P.rgvarg[1]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
    if Result <> S_OK then exit;
    repobj:=RForm.frReport.FindObject(String(V));
    Ms:=TMemoryStream.Create;
    SS:=TStringStream.Create(V1);
    Ss.Position:=0;
    DecodeStream(Ss,Ms);
    Ms.Position:=0;
    TfrPictureView(repobj).Picture.Bitmap.LoadFromStream(MS);
    SS.Free;
    MS.Free;
  end else
  Result := DISP_E_MEMBERNOTFOUND;
end;

end.
