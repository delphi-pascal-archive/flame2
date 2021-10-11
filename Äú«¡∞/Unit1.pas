unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  BRGB = record
   B:byte;
   G:byte;
   R:byte;
  end;
 
 TRgb=array[0..1000] of BRGB;
 PRGB=array[0..1000] of ^TRgb;

var
 Form1: TForm1;
 bit,bitp: TBitmap;
 b,b1: PRGB;

implementation

{$R *.dfm}

procedure BitMapToPointer(var PointerBitMap:PRgb; Bitmap:TBitMAp);
var
 i:integer;
 H:integer;
begin
 h:=bitmap.height-1;
 for i:=0 to h do
    PointerBitMap[i]:=Bitmap.ScanLine[i];
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 i,j:integer;
 r:integer;
begin
 bitp:=tbitmap.Create;
 bitp.LoadFromFile('1.bmp');
 bit:=tbitmap.Create;
 bit.Width:=501;
 bit.Height:=501;
 bit.PixelFormat:=pf24bit;
 bitmaptopointer(b,bit);
 bitmaptopointer(b1,bitp);
 for i:=1 to 500 do
   begin
    r:=-100+random(400);
    if r>255 then r:=255;
    if r<0 then r:=0;
    b[500,i].r:=r;
  end;
 for i:=1 to 500 do
    for j:=1 to 500 do
    begin
    b[j,i].R:=0;
   end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
 i,j:integer;
 r:integer;
begin
 for i:=2 to 500 do
    begin
    if i mod 4=0 then r:=-50+random(245);
    if r>255 then r:=255;
    if r<0 then r:=0;
    b[500,i].r:=r;
    end;
 for i:=1 to 500 do
    for j:=499 downto 1 do
        begin
         r:=round((b[j+1,i-1].r+b[j+1,i+1].r+b[j,i].R+b[j+1,i].R  +(-b1[j,i].r+random(b1[j,i].r)*2))*0.2533) ;
         r:=r-(-3+random(11));
         if (i=1) or (i=500) then r:=0;
         if r>255 then r:=255;
         if r<0 then r:=0 ;
         b[j,i].r:=(r);
         b[j,i].g:=(r div 2);
         b[j,i].b:=0;
        end;
 form1.Canvas.Draw(-1,-1,bit);
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
 i,j:integer;
 x1,y1:integer;
 x2,y2:integer;
begin
 bit.canvas.Pen.Color:=clred;
 for i:=-30 to 30 do
    for j:=-30 to 30 do
        begin
        if (sqrt(j*j+i*i)<30) and (sqrt(j*j+i*i)>20)  then
        bit.Canvas.Pixels[x+i,y+j]:=random(255);
 end;
end;

end.
