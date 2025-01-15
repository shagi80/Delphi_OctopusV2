unit FormTranslatorCls;

interface

{ Класс обеспечивающий перевод элементов интерфейса.
  Перевод обеспечивается по Id, которое необходимо записать в поле Tag.}


uses
  Classes, Forms;

type
  TFormTranslator = class(TObject)
  private
    FNewLanguage: integer;
    procedure TranslateProperty(component: TComponent; propInd: integer);
    const TRANSLATED_PROPERTY: array [0..1] of string = ('Caption', 'Hint');
  public
    constructor Create(newLanguage: integer);
    destructor Destroy(); override;
    procedure Translate(form: TForm);
  end;

implementation

uses
  TypInfo, TranslatorCls;

constructor TFormTranslator.Create(newLanguage: integer);
begin
  inherited Create;
  FNewLanguage := newLanguage;
end;

destructor TFormTranslator.Destroy;
begin
  inherited Destroy;
end;

procedure TFormTranslator.TranslateProperty(component: TComponent;
  propInd: integer);
var
  propValue, propName : string;
begin
  propName := TRANSLATED_PROPERTY[propInd];
  if GetPropInfo(component.ClassInfo, propName) <> nil then begin
    propValue := GetPropValue(component, propName);
    case propInd of
      0: propValue := Translator.GetInstance.TranslateCaption(
        component.Tag, propValue);
      1: propValue := Translator.GetInstance.TranslateHint(
        component.Tag, propValue)
    end;
    SetPropValue(component, propName, propValue);
  end;
end;

procedure TFormTranslator.Translate(form: TForm);
var
  i, j: integer;
begin
  TranslateProperty(form, 0);
  for i := 0 to form.ComponentCount - 1 do
    if form.Components[i].Tag > 0 then
      for j := 0 to high(TRANSLATED_PROPERTY) do
        TranslateProperty(form.Components[i], j);
end;

end.
